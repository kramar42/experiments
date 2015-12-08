#!/usr/bin/env groovy

def string = '"hello,my name,, is alex", ,and, what, is, "yours?"'

def processCSV(String string) {
    def splited = string.split(',') as ArrayList

    for (i in (0..splited.size() - 1)) {
        while (splited[i].findAll({it == '"'}).size() % 2 == 1) {
            splited[i] += ',' + splited[i+1]
            splited.remove(i + 1)
        }
    }

    splited.collect {
        it = it.trim()
        while (it.startsWith('"')) {
            it = it.substring(1, it.length() - 1)
            it.trim()
        }
        it
    }
}

println 'string: ' + string
println 'array:  ' + processCSV(string)

