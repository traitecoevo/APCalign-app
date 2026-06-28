
<!-- README.md is generated from README.Rmd. Please edit that file -->

# APCalign-app <img src="inst/APCalign_hex_2.svg" align="right" width="200"/>

<!-- badges: start -->
<!-- badges: end -->

‘APCalign-app’ is a Shiny interface to the [‘APCalign’ R
package](https://traitecoevo.github.io/APCalign/).

The app enables users to align their Australian plant taxon name strings
and update to current, accepted standards by the [Australian Plant
Census (APC)](Australian%20Plant%20Census%20(APC))

The app can be accessed at:
 https://unsw.shinyapps.io/APCalign-app/

### To run the app locally:

#### Installation:

This app is currently not on CRAN, to install its current development
version:

``` r
remotes::install_github("traitecoevo/APCalign-app")
```

#### Load app:

``` r
library(APCalignApp)

align_app()
```

## AusTraits family

`APCalign-app` is part of the **AusTraits family** of packages maintained by the
[AusTraits](https://austraits.org) team. See **[austraits.org](https://austraits.org)** for the
project, the data, and the people behind it.

Contributing? Issues across the family are tracked on one board,
[AusTraits #9](https://github.com/orgs/traitecoevo/projects/9), and new issues are auto-added. Please
read the [issue & labelling guide](https://github.com/traitecoevo/austraits-meta/blob/main/governance/issue-guide.md)
in [`austraits-meta`](https://github.com/traitecoevo/austraits-meta) — the family's cross-package
knowledge and governance hub — before filing.
