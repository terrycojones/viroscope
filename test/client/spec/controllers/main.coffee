'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'viroscope-app'

  MainCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/api/taxonomy').respond {
        "children": {
          "Caudovirales": {
            "children": {
              "Myoviridae": {
                "children": {
                  "Peduovirinae": {
                    "children": {
                      "Hpunalikevirus": {
                        "children": {
                          "Aeromonas phage phiO18P": {
                            "typeSpecies": 0
                          },
                          "Haemophilus phage HP1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "P2likevirus": {
                        "children": {
                          "Enterobacteria phage P2": {
                            "typeSpecies": 1
                          },
                          "Enterobacteria phage PsP3": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Spounavirinae": {
                    "children": {
                      "Spounalikevirus": {
                        "children": {
                          "Bacillus phage SPO1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Twortlikevirus": {
                        "children": {
                          "Listeria phage A511": {
                            "typeSpecies": 0
                          },
                          "Staphylococcus phage Twort": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Enterococcus phage phiEC24C": {
                            "typeSpecies": 0
                          },
                          "Lactobacillus phage LP65": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Tevenvirinae": {
                    "children": {
                      "Schizot4likevirus": {
                        "children": {
                          "Vibrio phage KVP40": {
                            "typeSpecies": 1
                          },
                          "Vibrio phage nt-1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "T4likevirus": {
                        "children": {
                          "Enterobacteria phage T4": {
                            "typeSpecies": 1
                          },
                          "Escherichia phage RB69": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage 42": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Acinetobacter phage 133": {
                            "typeSpecies": 0
                          },
                          "Aeromonas phage Aeh1": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Unassigned": {
                    "children": {
                      "Bcep78likevirus": {
                        "children": {
                          "Burkholderia phage Bcep1": {
                            "typeSpecies": 0
                          },
                          "Burkholderia phage Bcep781": {
                            "typeSpecies": 1
                          }                  }
                      },
                      "Bcepmulikevirus": {
                        "children": {
                          "Burkholderia phage BcepMu": {
                            "typeSpecies": 1
                          },
                          "Burkholderia phage phiE255": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Felixounalikevirus": {
                        "children": {
                          "Erwinia phage phiEa21-4": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage wV8": {
                            "typeSpecies": 0
                          },
                          "Salmonella phage FelixO1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Hapunalikevirus": {
                        "children": {
                          "Halomonas phage phiHAP-1": {
                            "typeSpecies": 1
                          },
                          "Vibrio phage VP882": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "I3likevirus": {
                        "children": {
                          "Mycobacterium phage I3": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Mulikevirus": {
                        "children": {
                          "Enterobacteria phage Mu": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Pbunalikevirus": {
                        "children": {
                          "Pseudomonas phage PB1": {
                            "typeSpecies": 1
                          },
                          "Pseudomonas phage SN": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Phicd119likevirus": {
                        "children": {
                          "Clostridium phage phiC2": {
                            "typeSpecies": 0
                          },
                          "Clostridium phage phiCD119": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Bacillus phage G": {
                            "typeSpecies": 0
                          },
                          "Bacillus phage PBS1": {
                            "typeSpecies": 0
                          },
                          "Microcystis aeruginosa phage Ma-LMM01": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Viunalikevirus": {
                        "children": {
                          "Salmonella phage ViI": {
                            "typeSpecies": 1
                          },
                          "Shigella phage Ag3": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  }
                }
              },
              "Podoviridae": {
                "children": {
                  "Autographivirinae": {
                    "children": {
                      "Phikmvlikevirus": {
                        "children": {
                          "Pantoea phage Limelight": {
                            "typeSpecies": 0
                          },
                          "Pantoea phage Limezero": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage LKA1": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage phiKMV": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Sp6likevirus": {
                        "children": {
                          "Enterobacteria phage K5": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage K1-5": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage K1E": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage SP6": {
                            "typeSpecies": 1
                          },
                          "Erwinia amylovora phage Era103": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "T7likevirus": {
                        "children": {
                          "Enterobacteria phage T7": {
                            "typeSpecies": 1
                          },
                          "Kluyvera phage Kvp1": {
                            "typeSpecies": 0
                          },
                          "Pseudomonad phage gh-1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Prochlorococcus phage P-SSP7": {
                            "typeSpecies": 0
                          },
                          "Synechococcus phage P60": {
                            "typeSpecies": 0
                          },
                          "Synechococcus phage syn5": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Picovirinae": {
                    "children": {
                      "Ahjdlikevirus": {
                        "children": {
                          "Staphylococcus phage 44AHJD": {
                            "typeSpecies": 1
                          },
                          "Streptococcus phage C1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Phi29likevirus": {
                        "children": {
                          "Bacillus phage B103": {
                            "typeSpecies": 0
                          },
                          "Bacillus phage GA-1": {
                            "typeSpecies": 0
                          },
                          "Bacillus phage phi29": {
                            "typeSpecies": 1
                          },
                          "Kurthia phage 6": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Actinomyces phage Av-1": {
                            "typeSpecies": 0
                          },
                          "Mycoplasma phage P1": {
                            "typeSpecies": 0
                          },
                          "Streptococcus phage Cp-1": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Unassigned": {
                    "children": {
                      "Bppunalikevirus": {
                        "children": {
                          "Bordetella phage BPP-1": {
                            "typeSpecies": 1
                          },
                          "Burkholderia phage BcepC6B": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Epsilon15likevirus": {
                        "children": {
                          "Escherichia phage PhiV10": {
                            "typeSpecies": 0
                          },
                          "Salmonella phage epsilon15": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Luz24likevirus": {
                        "children": {
                          "Pseudomonas phage LUZ24": {
                            "typeSpecies": 1
                          },
                          "Pseudomonas phage PaP3": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "N4likevirus": {
                        "children": {
                          "Escherichia phage N4": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "P22likevirus": {
                        "children": {
                          "Enterobacteria phage P22": {
                            "typeSpecies": 1
                          },
                          "Salmonella phage HK620": {
                            "typeSpecies": 0
                          },
                          "Salmonella phage ST64T": {
                            "typeSpecies": 0
                          },
                          "Shigella phage Sf6": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Phieco32likevirus": {
                        "children": {
                          "Enterobacteria phage Phieco32": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Endosymbiont phage APSE-1": {
                            "typeSpecies": 0
                          },
                          "Lactococcus phage KSY1": {
                            "typeSpecies": 0
                          },
                          "Phormidium phage Pf-WMP3": {
                            "typeSpecies": 0
                          },
                          "Phormidium phage Pf-WMP4": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage 119X": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage F116": {
                            "typeSpecies": 0
                          },
                          "Roseobacter phage SIO1": {
                            "typeSpecies": 0
                          },
                          "Vibrio phage VpV262": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  }
                }
              },
              "Siphoviridae": {
                "children": {
                  "Unassigned": {
                    "children": {
                      "C2likevirus": {
                        "children": {
                          "Lactococcus phage bIL67": {
                            "typeSpecies": 0
                          },
                          "Lactococcus phage c2": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "L5likevirus": {
                        "children": {
                          "Mycobacterium phage D29": {
                            "typeSpecies": 0
                          },
                          "Mycobacterium phage L5": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Lambdalikevirus": {
                        "children": {
                          "Enterobacteria phage HK022": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage HK97": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage lambda": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "N15likevirus": {
                        "children": {
                          "Enterobacteria phage N15": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Phic3unalikevirus": {
                        "children": {
                          "Streptomyces phage phiC31": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Psimunalikevirus": {
                        "children": {
                          "Methanobacterium phage psiM1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Spbetalikevirus": {
                        "children": {
                          "Bacillus phage SPbeta": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "T5likevirus": {
                        "children": {
                          "Enterobacteria phage T5": {
                            "typeSpecies": 1
                          },
                          "Escherichia phage Akfv33": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Bf23": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Eps7": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage H8": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage T5": {
                            "typeSpecies": 0
                          },
                          "Salmonella phage Spc35": {
                            "typeSpecies": 0
                          },
                          "Vibrio phage 149 (type IV)": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Tunalikevirus": {
                        "children": {
                          "Cronobacter phage Esp2949-1": {
                            "typeSpecies": 0
                          },
                          "Enterobacter phage F20": {
                            "typeSpecies": 0
                          },
                          "Enterobacteria phage T1": {
                            "typeSpecies": 1
                          },
                          "Escherichia phage Eb49": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Jk06": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Rogue1": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Rtp": {
                            "typeSpecies": 0
                          },
                          "Escherichia phage Tls": {
                            "typeSpecies": 0
                          },
                          "Shigella phage Shfl1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Yualikevirus": {
                        "children": {
                          "Phage phiJl001": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage M6": {
                            "typeSpecies": 0
                          },
                          "Pseudomonas phage Yua": {
                            "typeSpecies": 1
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          "Herpesvirales": {
            "children": {
              "Alloherpesviridae": {
                "children": {
                  "Unassigned": {
                    "children": {
                      "Batrachovirus": {
                        "children": {
                          "Ranid herpesvirus 1": {
                            "typeSpecies": 1
                          },
                          "Ranid herpesvirus 2": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Cyprinivirus": {
                        "children": {
                          "Anguillid herpesvirus 1": {
                            "typeSpecies": 0
                          },
                          "Cyprinid herpesvirus 1": {
                            "typeSpecies": 0
                          },
                          "Cyprinid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Cyprinid herpesvirus 3": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Ictalurivirus": {
                        "children": {
                          "Acipenserid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Ictalurid herpesvirus 1": {
                            "typeSpecies": 1
                          },
                          "Ictalurid herpesvirus 2": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Salmonivirus": {
                        "children": {
                          "Salmonid herpesvirus 1": {
                            "typeSpecies": 1
                          },
                          "Salmonid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Salmonid herpesvirus 3": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  }
                }
              },
              "Herpesviridae": {
                "children": {
                  "Alphaherpesvirinae": {
                    "children": {
                      "Iltovirus": {
                        "children": {
                          "Gallid herpesvirus 1": {
                            "typeSpecies": 1
                          },
                          "Psittacid herpesvirus 1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Mardivirus": {
                        "children": {
                          "Anatid herpesvirus 1": {
                            "typeSpecies": 0
                          },
                          "Columbid herpesvirus 1": {
                            "typeSpecies": 0
                          },
                          "Gallid herpesvirus 2": {
                            "typeSpecies": 1
                          },
                          "Gallid herpesvirus 3": {
                            "typeSpecies": 0
                          },
                          "Meleagrid herpesvirus 1": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Chelonid herpesvirus 6": {
                            "typeSpecies": 0
                          }
                        }
                      },
                    }
                  },
                  "Betaherpesvirinae": {
                    "children": {
                      "Cytomegalovirus": {
                        "children": {
                          "Human herpesvirus 5": {
                            "typeSpecies": 1
                          },
                          "Macacine herpesvirus 3": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Muromegalovirus": {
                        "children": {
                          "Murid herpesvirus 1": {
                            "typeSpecies": 1
                          },
                          "Murid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Murid herpesvirus 8": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Proboscivirus": {
                        "children": {
                          "Elephantid herpesvirus 1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Roseolovirus": {
                        "children": {
                          "Human herpesvirus 7": {
                            "typeSpecies": 0
                          },
                          "Human herpesvirus 6A": {
                            "typeSpecies": 1
                          },
                          "Human herpesvirus 6B": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Caviid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Suid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Tupaiid herpesvirus 1": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Gammaherpesvirinae": {
                    "children": {
                      "Lymphocryptovirus": {
                        "children": {
                          "Callitrichine herpesvirus 3": {
                            "typeSpecies": 0
                          },
                          "Human herpesvirus 4": {
                            "typeSpecies": 1
                          },
                          "Pongine herpesvirus 2": {
                            "typeSpecies": 0
                          }
                        }
                      },
                      "Rhadinovirus": {
                        "children": {
                          "Murid herpesvirus 7": {
                            "typeSpecies": 0
                          },
                          "Saimiriine herpesvirus 2": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Unassigned": {
                        "children": {
                          "Equid herpesvirus 7": {
                            "typeSpecies": 0
                          },
                          "Phocid herpesvirus 2": {
                            "typeSpecies": 0
                          },
                          "Saguinine herpesvirus 1": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  },
                  "Unassigned": {
                    "children": {
                      "Unassigned": {
                        "children": {
                          "Iguanid herpesvirus 2": {
                            "typeSpecies": 0
                          }
                        }
                      }
                    }
                  }
                }
              },
              "Malacoherpesviridae": {
                "children": {
                  "Unassigned": {
                    "children": {
                      "Aurivirus": {
                        "children": {
                          "Haliotid herpesvirus 1": {
                            "typeSpecies": 1
                          }
                        }
                      },
                      "Ostreavirus": {
                        "children": {
                          "Ostreid herpesvirus 1": {
                            "typeSpecies": 1
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

    $httpBackend.expectGET('/api/properties').respond {
        "children": {
            "Caudovirales": {
                "properties": {
                    "genome": {
                        "type": "dsDNA"
                    },
                    "envelope": false,
                    "morphologyKeywords": "icosahedral head with tail",
                    "virionSize": [60, 145],
                    "genomeSize": [16, 317],
                    "host": ["B", "Ar"]
                },
                "children": {
                    "Myoviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": false,
                            "morphology": "icosahedral head with tail",
                            "virionSize": [60, 145],
                            "genomeSize": [31, 317],
                            "host": ["B", "Ar"]
                        }
                    },
                    "Podoviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": false,
                            "morphology": "icosahedral head with short tail",
                            "virionSize": [60, 70],
                            "genomeSize": [16, 78],
                            "host": ["B"]
                        }
                    },
                    "Siphoviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": false,
                            "morphology": "icosahedral head with tail",
                            "virionSize": [40, 80],
                            "genomeSize": [21, 134],
                            "host": ["B", "Ar"]
                        }
                    }
                }
            },
            "Herpesvirales": {
                "properties": {
                    "genome": {
                        "type": "dsDNA"
                    },
                    "envelope": true,
                    "morphologyKeywords": "spherical icosahedral core",
                    "virionSize": [160, 300],
                    "genomeSize": [125, 295],
                    "host": ["V", "I"]
                },
                "children": {
                    "Alloherpesviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": true,
                            "morphology": "spherical virion, icosahedral core",
                            "virionSize": [160, 300],
                            "genomeSize": [134, 295],
                            "host": ["V"]
                        }
                    },
                    "Herpesviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": true,
                            "morphology": "spherical virion, icosahedral core",
                            "virionSize": [160, 300],
                            "genomeSize": [125, 241],
                            "host": ["V"]
                        }
                    },
                    "Malacoherpesviridae": {
                        "properties": {
                            "genome": {
                                "type": "dsDNA"
                            },
                            "envelope": true,
                            "morphology": "icosahedral",
                            "virionSize": [160, 300],
                            "genomeSize": 207,
                            "host": ["I"]
                        }
                    }
                }
            }
        }
    }

    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'should attach a list of viruses to the scope', ->
    expect(scope.data).toBeUndefined()
    $httpBackend.flush()
    expect(scope.selectedNode).toBe null

  it 'new node', ->
    n = new Node('hey', null, {}, 4)
    expect(n.name).toBe 'hey'

  it 'Malacoherpesviridae properties to have an undefined morphologyKeywords', ->
    $httpBackend.flush()
    expect(scope._converted.children[1].name).toBe 'Herpesvirales'
    expect(scope._converted.children[1].children[2].name).toBe 'Malacoherpesviridae'
    malaco = scope._converted.children[1].children[2]
    expect(malaco.properties.morphology).toBe 'icosahedral'
    expect(malaco.properties.morphologyKeywords).toBe 'icosahedral'
