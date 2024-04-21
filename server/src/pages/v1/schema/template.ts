import type { APIRoute } from "astro";
import template from "../../../data/template.json";

export const prerender = false;

export const GET: APIRoute = async function () {
  return new Response(JSON.stringify(template), {
    status: 200,
  });
};
