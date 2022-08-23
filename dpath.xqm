xquery version "3.1";

(:
: Module Name: Dynamic XPath Parser
: Module Version: 0.1
: Copyright: GNU General Public License v3.0
: Proprietary XQuery Extensions Used: None
: XQuery Specification: 08 April 2014
: Module Overview: This module contains utility functions that extend the
:                  functx:dynamic-path function allowing more robust parsing
:                  of xpaths at run-time. Supports predicates, wildcards, and
:                  descendant and parent axes.
:)

(:~ 
: @author William L. Potter
: @version 0.1
 :)
 
module namespace dpath="https://wlpotter.github.io/ns/dpath";

import module namespace functx="http://www.functx.com";
(:
XQuery module for dynamically parsing XPaths written in the compact synatx.

Given a node and a string representing an xpath, should be able to return the targeted node(s)

Should handle:

- child and descendant steps (`/` and `//`)
- parent steps (`..`)
- ancestor steps using 
- attributes (`@`)
- node types (e.g., `/node()`, `/text()`, `/string()`, etc.)
- wildcard characters (`*` and `@*`)
- predicates
  - simple positional predicates (`[1]`)
  - complex positional predicates (e.g., `[position() > 1]`)
  - full support of predicate logic (and, or, etc.)
- namespaces
  - with predicates
  - with bound namespace prefixes (if that's possible...)

relies heavily on, and extends, the functx library, particularly functx:dynamic-path ; functx:substring-before-if-contains ; and their other dependencies
:)

declare function dpath:dynamic-path
  ( $parent as node() ,
    $path as xs:string )  as item()* {

  let $nextStep := functx:substring-before-if-contains($path,'/')
  let $restOfSteps := substring-after($path,'/')
  for $child in
    ($parent/*[functx:name-test(name(),$nextStep)],
     $parent/@*[functx:name-test(name(),
                              substring-after($nextStep,'@'))])
  return if ($restOfSteps)
         then dpath:dynamic-path($child, $restOfSteps)
         else $child
 };
 
declare function dpath:parse-path
  ( $path as xs:string )
as node()*
{
  (: take an xs:string representing an xpath and divide it itnto steps :)
  (:
  tokenize, in order, on:
  - `|`, represents multiple paths
  - `//`, represents ancestor steps
  - `/`, represents child steps
  - `[]`, not a tokenize but anything here is a predicate
  :)
  (:
  once the steps have been tokenized, you can return them. another function should then parse each step to determine what action should be taken
  :)
};

(: I think i might just, for now, have to hack the positional predicates together and then come back and build this module out... :)