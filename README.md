# Danish-pronunciation

A useful tool for learning the **Danish language**. This project consists provides code that can retrieve a pronunciation file for a given Danish word.

The program first tries to download from [ Den Danske Ordbog](http://ordnet.dk/ddo), then from [Forvo](https://forvo.com/).

Please read [Forvo's terms of service](https://api.forvo.com/documentation/general-information/) and conditions carefully to see if the usage you want to give to their files is adequate!



### Prerequisites

Needs a working installation of R and the CRAN packages **rvest**, **httr** and **dplyr**

Type in the linux shell:

```
R
library("rvest")
library("httr")
library("dplyr")
```

If you executed this succesfully, then you should be able to run the programme.

If you need to get them, you can install them.

```
R
lapply(list("rvest", "httr", "dplyr"), install.packages)
```

If you need to install R, please follow [this guide](http://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/src/installr.html).

### Installing

Clone the repository

```
git clone https://github.com/antortjim/Danish-pronunciation.git
```
Alternatively, you may download the files manually from Github.

Once downloaded, edit the input_parameters file to feature the destination folder in your system.

### Test

Call the programme passing Danish words

```
udtale første
```

No audio file is found in Den Danske Ordbog, but one is found in Forvo. The første.mp3 file is downloaded to the folder specified in input_parameters.

```
udtale regning
```

A file is found in Den Danske Ordbog. The regning.mp3 file is downloaded and Forvo is not searched.

## Trivia

*Udtale* means Pronunciation in Danish.
 
## Authors

* **Antonio Ortega**


## License

This project is licensed under the GNU Public License - see the [LICENSE](LICENSE) file for details.
