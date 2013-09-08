package prime

import (
  "fmt"
  "strings"
  "bufio"
  "os"
  "log"
  "bytes"
)

// Prime uses a tree to represent it's knowledge base. This is called
// the Knowledge Tree.
type Tree struct {
	  Value  string     // atomic value
    Count  int        // number of nodes below
    Parent *Tree      // pointer to parent node
  	Branches []*Tree  // pointers to branches
}

// matchBranch finds a matching branch node for a given
// atom. If there are no matches it returns ...
func (tree *Tree) matchBranch(atom string) (*Tree, bool) {
    for i := 0; i < len(tree.Branches); i++ {
        branch := *tree.Branches[i]
        if branch.Value == atom {
          return &branch, true
        }
    }
    return tree, false
}

//
//
//
func (tree *Tree) addBranch(atom string) Tree {
    branch := Tree{Value: atom, Parent: tree}
    tree.Branches = append(tree.Branches, &branch)
fmt.Printf("size is %d\n", len(tree.Branches))
    // TODO: update counts
    return branch
}

//
//
func (tree *Tree) addBranchOfAtoms(atoms []string) {
    parent := *tree
    for _, atom := range atoms {
        parent = parent.addBranch(atom)
    }
}

//
//
func (tree Tree) Dump() {
    tree.dumpN(0)
}

//
//
func (tree Tree) dumpN(depth int) {
  fmt.Printf("%d\n", len(tree.Branches))
    for _, b := range tree.Branches {
        fmt.Printf("%s> %s", strings.Repeat("--", depth), b.Value)
        b.dumpN(depth + 1)
    }
}

//
func RunProgramFile(programFile string) Tree {
    ktree := Tree{}
    EvalFile(programFile, ktree)
    return ktree
}

// EvalFile evaluate a file.
func EvalFile(programFile string, ktree Tree) {
    var buffer bytes.Buffer
    file, _ := os.Open(programFile)
    scanner := bufio.NewScanner(file) //os.Stdin)
    for scanner.Scan() {
        buffer.WriteString(scanner.Text())
    }
    if err := scanner.Err(); err != nil {
        log.Fatal(err)
    }
    program := buffer.String()
    Eval(program, ktree)
}

// Eval takes a string and evaluates it as a prime program.
func Eval(program string, ktree Tree) Tree {
   statements := strings.Split(program, ".")
   for _, statement := range statements {
     evalStatement(statement, ktree)
   }
   return ktree
}

// parseLine parses a program string into the knowledge tree
// that represents the knowledge tree of the Prime program.
//
func evalStatement(statement string, ktree Tree) Tree {
    statement = strings.TrimSpace(statement)
    // skip blanks
    if statement == "" { return ktree }
    // TODO: skip comments
    // TODO: remove trailing comments
    atoms := splitAtoms(statement)
    newFact(atoms, ktree)
    return ktree
}

// newFact adds a fact to a knowledge tree.
func newFact(fact []string, ktree Tree) {
    node := ktree
    for i, atom := range fact {
        match, success := node.matchBranch(atom)
        if success {
            node = *match
        } else {
            node.addBranchOfAtoms(fact[i:cap(fact)])
            break
        }
    }
}

//
func splitAtoms(statement string) []string {
    atoms := strings.Split(statement, " ")
    for _, atom := range atoms {
        fmt.Println(atom)
    }
    return atoms
}

