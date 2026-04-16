# AGENTS

This repository is a small collection of independent 3D model projects, mostly authored in OpenSCAD.

Guidelines:

- Treat each top-level model directory as a self-contained project: keep its `.scad`, `README.md`, and preview/reference assets together.
- Prefer small, local edits. Avoid cross-folder refactors unless the same change is clearly needed in multiple models.
- Keep OpenSCAD files readable and parameter-driven when practical; preserve existing simple naming and structure.
- When adding or changing a model, update that folder's `README.md` with a short description and at least one image reference if relevant.
- Keep docs lightweight. Match the repo's style: brief explanations, practical context, and images over long prose.
- Do not overwrite user work in progress. Check for existing local changes before editing nearby files.
- Shared helpers belong in `_common/`; only move code there when reuse is real, not speculative.
