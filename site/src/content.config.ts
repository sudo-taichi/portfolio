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
    summary: z.string(),
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
    summary: z.string(),
    order: z.number(),
  }),
});

const about = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/about" }),
  schema: z.object({
    summary: z.string(),
  }),
});

const certifications = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/certifications" }),
  schema: z.object({
    certList: z.array(
      z.object({
        name: z.string(),
        date: z.string(),
        tier: z.string(),
        highlight: z.boolean().default(false),
      }),
    ),
  }),
});

const activities = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/activities" }),
  schema: z.object({
    summary: z.string(),
  }),
});

export const collections = { works, skills, about, certifications, activities };
