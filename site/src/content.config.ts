import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const works = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/works" }),
  schema: z.object({
    // 掲載順 = 技術的インパクト順（時系列順ではない）
    order: z.number(),
    title: z.string(),
    period: z.string(),
    role: z.string().optional(),
    challenge: z.string().optional(),
    approach: z.string(),
    result: z.string().optional(),
    tech: z.array(z.string()),
    note: z.string().optional(),
  }),
});

const skills = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/skills" }),
  schema: z.object({
    category: z.enum(["cloud", "iac", "security", "pm"]),
    categoryLabel: z.string(),
    title: z.string(),
    order: z.number(),
  }),
});

export const collections = { works, skills };
