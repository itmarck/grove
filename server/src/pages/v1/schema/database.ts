import type { APIRoute } from "astro";

export const GET: APIRoute = async function () {
  return new Response(null, {
    status: 200,
  });
};
