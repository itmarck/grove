import type { APIRoute } from "astro";

export const prerender = false;

const tokenUrl = "https://api.notion.com/v1/oauth/token";

const clientId = import.meta.env.NOTION_CLIENT_ID;
const secret = import.meta.env.NOTION_CLIENT_SECRET;
const redirectUrl = import.meta.env.NOTION_REDIRECT_URL;

const headers = {
  "Content-Type": "application/json",
};

export const POST: APIRoute = async function ({ request }) {
  const requestBody = await json(request);
  const response = await post(tokenUrl, requestBody);
  const body = await json(response);

  if (!response.ok) {
    return new Response(encode(body), {
      status: response.status,
      headers: headers,
    });
  }

  if (Object.keys(body).length <= 0) {
    return new Response(null, {
      status: 400,
      headers: headers,
    });
  }

  return new Response(encode(body), {
    status: 200,
    headers: headers,
  });
};

async function post(url: string, body: { code: string }) {
  const credentials = btoa(`${clientId}:${secret}`);
  const response = await fetch(url, {
    method: "POST",
    headers: {
      Authorization: `Basic ${credentials}`,
      ...headers,
    },
    body: encode({
      grant_type: "authorization_code",
      code: body.code,
      redirect_uri: redirectUrl,
    }),
  });

  return response;
}

async function json(source: Request | Response) {
  try {
    return await source.json();
  } catch {
    return {};
  }
}

function encode(data: any) {
  try {
    return JSON.stringify(data);
  } catch {
    return "{}";
  }
}
