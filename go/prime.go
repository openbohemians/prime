package main

import (
    "flag"
    "fmt"
    "os"
    "openworks.github.com/prime"
)

func usage() {
    fmt.Fprintf(os.Stderr, "usage: prime [file]\n")
    flag.PrintDefaults()
    os.Exit(2)
}

func main() {
    flag.Usage = usage
    flag.Parse()

    args := flag.Args()
    if len(args) < 1 {
        fmt.Println("Program file is missing.")
        os.Exit(1)
    }

    ktree := prime.RunProgramFile(args[0])

    ktree.Dump()
}

