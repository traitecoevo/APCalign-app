# APCalign-app — agent & contributor guide

`APCalign-app` (package `APCalignApp`) is a **Shiny web interface to the
[`APCalign`](https://traitecoevo.github.io/APCalign/) R package** — it lets users align and update
Australian plant taxon name strings to the currently accepted standards of the Australian Plant
Census (APC).

## Repo-local guidance

- **Packaged as an R package, run as a Shiny app.** Standard R-package layout (`DESCRIPTION`,
  `NAMESPACE`, `man/`, `R/`, `tests/`) but the only exported function is `align_app()`, which builds
  and launches the Shiny app.
- **Entry point:** `R/app.R` defines `align_app()` — it calls
  `APCalign::load_taxonomic_resources()` once, then assembles `apcalign_ui()` /
  `apcalign_server()` and runs `shiny::shinyApp()`.
- **App code in `R/`:** `ui.R` (`apcalign_ui()`), `server.R` (`apcalign_server()`), `global.R`,
  `get_started.R` and `faqs.R` (UI tab content), `upload.R` (file-upload handling). `inst/www/`
  holds the app's stylesheet and navbar logo, served under `www/` via `addResourcePath()`.
- **Styling:** the UI is a `bslib::page_sidebar()` themed to match austraits.org — a `simplex`
  preset with the AusTraits palette, plus `inst/www/apcalign-app.css`. That stylesheet is kept
  deliberately in step with `austraits.portal/inst/www/austraits-portal.css` so the two hosted apps
  read as one platform; change both together. The app is also embedded in an iframe on
  [austraits.org/apcalign.html](https://austraits.org/apcalign.html), so keep the layout working at
  narrow widths.
- **Top-level `app.R`** is the deploy entry point: `pkgload::load_all("."); align_app()` — this is
  what a Posit Connect / shinyapps.io deployment runs.
- **Run locally** (per the README): `remotes::install_github("traitecoevo/APCalign-app")`, then
  `library(APCalignApp); align_app()`. For dev from a checkout, the standard R-package workflow
  applies: `devtools::load_all()`, `devtools::test()`, `devtools::check()`.
- **Tests:** `tests/testthat/` (testthat edition 3) — `test-taxonomic_update.R`, `test-upload.R`;
  `shinytest` is a suggested dependency.
- **Hosting:** the app is deployed publicly (README points to a UNSW shinyapps.io / Posit Connect
  URL). Default branch is `master`.

> Heads-up: `align_app()` calls `APCalign::load_taxonomic_resources()` at startup, which downloads
> the APC/APNI taxonomic data — startup is slow and needs network access. `DESCRIPTION` also pins
> `shiny (<= 4.2.3)`, so check Shiny version compatibility before bumping dependencies.

---

## AusTraits family — cross-package context

`APCalign-app` is part of the **AusTraits family** (a subset of the
[`traitecoevo`](https://github.com/traitecoevo) org) — here, a web/Shiny app front-end for
APCalign. Family-wide concerns are documented centrally in
**[austraits-meta](https://github.com/traitecoevo/austraits-meta)** — don't restate them here, read
them there:

- **Start with [`AGENTS.md`](https://github.com/traitecoevo/austraits-meta/blob/main/AGENTS.md)** —
  pipeline order, who owns what, dependency direction, source-of-truth rules, cross-boundary
  artifacts, gotchas.
- **[`dependencies.yml`](https://github.com/traitecoevo/austraits-meta/blob/main/dependencies.yml)** —
  machine-readable package graph + cross-boundary artifacts.
- **[`governance/`](https://github.com/traitecoevo/austraits-meta/tree/main/governance)** —
  label taxonomy, board #9 conventions, release playbooks, triage.

**Filing issues:** the whole family is tracked on one board,
[AusTraits #9](https://github.com/orgs/traitecoevo/projects/9) (new issues auto-add to it). Follow
the [issue & labelling guide](https://github.com/traitecoevo/austraits-meta/blob/main/governance/issue-guide.md):
pick one work-type label (`bug` / `task` / `epic`); Status and Priority are set on the board, not as
labels.

> austraits-meta is hand-maintained prose — a map, not ground truth. Verify specifics against the
> actual repos.
