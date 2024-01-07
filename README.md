# xopotel - Golang connector between Open Telemetry and XOP (Cross Observability Platform)

[![Stability: Experimental](https://masterminds.github.io/stability/experimental.svg)](https://masterminds.github.io/stability/experimental.html)
[![GoDoc](https://godoc.org/github.com/xoplog/xopotel-go?status.png)](https://pkg.go.dev/github.com/xoplog/xopotel-go)
![unit tests](https://github.com/xoplog/xopotel-go/actions/workflows/go.yml/badge.svg)
[![report card](https://goreportcard.com/badge/github.com/xoplog/xopotel-go)](https://goreportcard.com/report/github.com/xoplog/xopotel-go)
[![codecov](https://codecov.io/gh/xoplog/xop-go/branch/main/graph/badge.svg)](https://codecov.io/gh/xoplog/xopotel-go)

Package xopotel provides gateways/connections between 
[xop](https://github.com/muir/xop-go) 
[OpenTelemetry](https://opentelemetry.io/).

## 

## `SpanToLog`

`SpanToLog()` allows xop to be used as a logger to add "Events" to an 
existing OTEL span.

## `SeedModifier`

SeedModifier allows using an OTEL Tracer as an xopbase.Logger

## `BaseLogger`

`BaseLogger()` creates a `xopbase.Logger` that can be used as a
to gateway xop logs and spans into OTEL.

## Compatibility

### Data types

OTEL supports far fewer data types than xop.  Mostly, xop types
can be converted cleanly, but links are a special case: links can
only be added to OTEL spans when the span is created.  Since xop
allows links to be made at any time, links will be added as
ephemeral sub-spans.  Distinct, Multiple, and Locked attributes will
be ignored for links.

OTEL does not support unsigned ints. `uint64` will be converted to a
string and smaller unsigned ints will convert to `int64`.

OTEL provides no way to record links (trace_id/span_id) except as part
of the initial set of "Links" associated with a span.  Those links are
values only (no key, no name).  Xop supports arbitrary numbers of links
on a per-logline basis.  There is no way to record those as links using
the OTEL structures so if there is more than one of them, then they'll
be recorded as strings.  Most of the time, a log line won't have more
than one trace reference.

For both events with links, and links as span metadata, an extra OTEL
span will be created just to hold the link.  The extra span will be marked
with span.is-link-attribute:true for span metadata and 
span.is-link-event for events.

