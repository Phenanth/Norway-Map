# Norway Document

This document consists of these four parts:
- Requirements can be accomplished with current data
- Requirement Confirmation
- Missing Data
- Requirement Questions

---

## Requirements can be accomplished with current data

Based on the project given, two requirements are *almost* accomplished:
- Window 1
- Window 3

I will sum up the work had been done before.
If any of my conception is wrong, please let me know about it.

### Window 1

Marks(cycles) on the google map, each represents a dataset from its `ENDPOINT`, they are:
- CAMPAIGN ('JOVA')
- COUNTRY ('NORWAY')
- ENDPOINT (Data from `ENDPOINT` column)
- SUM (Calculated values)
- TOTAL (Calculated values)

### Window 3

A Highcharts reflecting `SPECIES_GROUP`, `ENDPOINTS`, when mouse is hovering each dataset of those ENDPOINTS, a pop-up window will be shown in window 1.
An `individual selection panes` is also available to select which type of `SPECIES_GROUP` would be displayed in the chart.

---

## Requirement Confirmation

In this part, the confirmation process of all requirements will procedure in following orders:
- Data
- Window 3
- Window 2
- Window 1

> Window 4 is not in this part, check it in `Requirement Questions`.

### Data

Though the raw data (from the dsv file) would be used in Window 3 are `SPECIES_GROUP`, `ENDPOINT`, `SITE_CODE`, I still want to confirm that whether the options in `individual selection panes for each window` are the rows in `SPECIES_GROUP`? Please let me know if my conception is right.

Since the window 2 will contain a time slider function, is it necessary to add an additional date column to the sample data?
The whole sample dataset will contain these columns:

- CAMPAIGN ('JOVA')
- SITE_CODE (Data from `ENDPOINT` column)
- SPECIES_GROUP (Data from `SPECIES_GROUP` column)
- ENDPOINT (Data from `ENDPOINT` column, currently a missing column but will be added if necessary, explanation is below in `Requirement Confirmation - Window 3`)
- TOTAL (Data from `TOTAL` column, currently a missing column but will be added if necessary.)
- SUM (Calculated value)
- TOTAL_SUM (Calculated value)
- lat (Latitudes of each `ENDPOINT`)
- lon (Longitude of each `ENDPOINT`)
- COUNTRY ('NORWAY')
- SITE_NAME (Names of each `ENDPOINGT`)

### Window 3

Although window 3 is almost finished in the previous program, based on the new data I've received - which is quite different from the data used in the last time, there would possibly be some changes in the program (like adding more options in the `individual selection panes`) if necessary.

I've checked the codes of the previous program, and I think it is better to add an `ENDPOINT` column in the `mapdata.js`, because I see a necessity in displaying the `ENDPOINT` in window 1. 

### Window 2

A chart displaying the trends of each different `SPECIES_GROUP` in selected `ENDPOINT` in a timeline.
Also, is the data in y coordinate the value of `TOTAL` column in that date?

> There might be some changes in the sample dataset `mapdata.js`, since the `SAMPLE_DATE` and `TOTAL` column is currently missing.

### Window 1

I would like to confirm how to calculate `SUM` and `TOTAL` displayed in the pop-up window.
Here's my hypothesis:

#### SUM

Average of values from `SUM_Q_AVG` column of this `ENDPOINT` in different `SAMPLE_DATE`.
Each `SPECIES_GROUP` will be independent. (Since it is the sum of a single `SPECIES_GROUP`?)
When displaying in window 1, all `SUM` value in datasets of each `SPECIES_GROUP` would be added together.

#### TOTAL_SUM

Average of the sum of the values from `TOTAL` column of this `ENDPOINT` in different `SAMPLE_DATE`.
Would add up all the `SPECIES_GROUP` together. (Since it is the sum of all the `SPECIES_GROUP` in this `ENDPOINT`?)


---

## Missing Data

There is also some type of data that I want to attain, I'll show you in below.

- Names of each `ENDPOINT`, for displaying in the window 3
- Shorthand for `SPECIES_GROUP`, for displaying in `individual selection panes`
- Longitudes of each `ENDPOINT`, for displaying in the window 1
- Latitudes of each `ENDPOINT`, for displaying in the window 1

> The last two data may be calculated if the first one is given.
> Also, not all the `ENDPOINT` have those data in `SPECIES_GROUP`, so it is possible that not all SPECIES are in window 2's chart.

---

## Requirement Questions

The most uncertain part is about the requirement of window 4.
I didn't understand what do the shorthand represent in the explanation of window 4, but I do see that window 4 may some graphs made in R and are just inserted in the web.
Is it suitable to consider that what I should do is just leave a blank place in the web program for window 4?
If not, could you please explain the requirements of window 4 in a more detailed way? It would be really appreciated.
