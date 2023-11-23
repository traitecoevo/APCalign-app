
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
<https://posit-connect-unsw.intersect.org.au/APCalign-app/>

### To run the app locally:

#### Installation:

This app and its main dependency `APCalign` which is currently not on
CRAN. We will need install both of these from GitHub:

``` r
remotes::install_github("traitecoevo/APCalign")

remotes::install_github("traitecoevo/APCalign-app")
```

#### Load app:

``` r
library(APCalignApp)

align_app()
```
