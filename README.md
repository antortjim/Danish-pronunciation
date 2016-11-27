# Danish-pronunciation

A useful tool for learning the **Danish language**. This project consists provides code that can retrieve a pronunciation file for a given Danish word.

The program first tries to download from [ Det Danske Ordbog](http://ordnet.dk/ddo) , then from [Wiktionary](https://en.wiktionary.org/wiki/Wiktionary:Main_Page) . Support is required for searching [ Forvo](forvo.com) .


These audio files can be very useful to use in conjunction with learning software such as Anki.


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

Once dowloaded, edit the input_parameters file to feature the destination folder in your system.

### Test

Call the programme passing Danish words

```
udtale første
```

No audio file is found in Den Danske Ordbog, but one is found in Wiktionary. The første.ogg file is downloaded to the folder specified in input_parameters.

```
udtale regning
```

A file is found in Den Danske Ordbog. The regning.mp3 file is downloaded and Wiktionary is not searched.


## Authors

* **Antonio Ortega**

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the GNU Public License - see the [LICENSE](LICENSE) file for details.