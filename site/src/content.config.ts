import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const works = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/works" }),
  schema: z.object({
    title: z.string(),
    period: z.string(),
    role: z.string().optional(),
    teamSize: z.number().optional(),
    phase: z.array(z.string()).min(1),
    stack: z.array(z.string()),
    featured: z.boolean().default(false),
    order: z.number(),
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

const about = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/about" }),
  schema: z.object({}),
});

const certifications = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/certifications" }),
  schema: z.object({}),
});

const activities = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/activities" }),
  schema: z.object({}),
});

export const collections = { works, skills, about, certifications, activities };
