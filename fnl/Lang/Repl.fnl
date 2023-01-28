(local iron (require :iron.core))
(iron.setup {:config {:repl_definition {:fennel {:command [:rlwrap :fennel]}
                                        :rust {:command [:evcxr]}}}})
