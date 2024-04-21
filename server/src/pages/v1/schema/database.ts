import type { APIRoute } from "astro";
import database from "../../../data/database.json";

export const prerender = false;

export const GET: APIRoute = async function ({ request }) {
  const url = new URL(request.url);
  const parentId = url.searchParams.get("parent");

  if (!parentId) {
    const error = {
      message: "Missing parent query param",
    };

    return new Response(JSON.stringify(error), {
      status: 400,
    });
  }

  database.parent.page_id = parentId;

  return new Response(JSON.stringify(database), {
    status: 200,
  });
};
