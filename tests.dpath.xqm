xquery version "3.1";

(:
: Module Name: Unit Testing for Dynamic XPath Parser
: Module Version: 0.1
: Copyright: GNU General Public License v3.0
: Proprietary XQuery Extensions Used: None
: XQuery Specification: 08 April 2014
: Module Overview: This module contains unit tests for developing the Dynamic XPath Parsers.
:)

module namespace dpath-test="https://wlpotter.github.io/ns/dpath-test";

import module namespace dpath="https://wlpotter.github.io/ns/dpath" at "dpath.xqm";

declare variable $dpath-test:parent-node :=
<root>
  <a></a>
  <b></b>
  <c></c>
</root>
;

(: Single step paths :)
declare %unit:test function dpath-test:single-child-step-one-matching-node() {
  unit:assert-equals(dpath:dynamic-path($dpath-test:parent-node, "b"), <b/>)
};

(:
tests needed

tokenizing the pieces of a path into their parts

simple paths

- single child step with a single matching node
- single child step with multiple matching nodes
- single child step with no matching nodes
- multiple child steps with single matching node
- multiple child steps with multiple matching nodes
- multiple child steps with no matching nodes

descendant paths

- single descendant step with a single matching node
- single descendant step with multiple matching nodes
- single descendant step with no matching nodes
- multiple descendant steps with single matching node
- multiple descendant steps with multiple matching nodes
- multiple descendant steps with no matching nodes

parent paths

- single parent step with a single matching node
- single parent step with multiple matching nodes
- single parent step with no matching nodes
- multiple parent steps with single matching node
- multiple parent steps with multiple matching nodes
- multiple parent steps with no matching nodes

predicates -- simple positional (numerical notation)

predicates -- complex positional (logical notation, e.g. 'position() > 1')

predicates -- simple filtering (e.g., `[@n]` to filter elements that have a child @n attribute)

predicates -- full on predicate logic 
- one way to do this in development would be to parse anything that has parens and treat it as a function, though you'd need an implementation-specific dynamic eval function (BaseX has one I think)

node types (node(), text(), string())

wild cards (* and @*)

namespaces

long-form xpath axes (`::self`, etc.)

pipe operator to chain multiple paths...

how these work together...

errors and error handling
:)