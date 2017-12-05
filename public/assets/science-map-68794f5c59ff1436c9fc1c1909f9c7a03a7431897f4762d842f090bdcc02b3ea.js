      //Width and height
      var w = window.innerWidth;
      var h = 400;

      //Original data
      var dataset = {
        nodes: [
          { name: "Biochemistry" },
          { name: "Cell Biology" },
          { name: "Molecular Biology" },
          { name: "Developmental and Reproductive Biology" },
          { name: "Immunology" },
          { name: "Bioinformatics" },
          { name: "Oncology" },
          { name: "Cell and Nuclear Division" },
          { name: "Computational Biology" },
          { name: "Epigenetics" },
          { name: "Enzymes" },
          { name: "Genetics" },
          { name: "Genomics" },
          { name: "Transcriptomics" },
          { name: "Proteomics" },
          { name: "Pharmacology" },
          { name: "Pathology" },
          { name: "Population, Ecological, and Evolutionary Genetics" },
          { name: "Receptors and Membrane Biology" },
          { name: "Synthetic Biology" },
          { name: "Systems Biology" },
          { name: "Toxicology" },
          { name: "Virology" },
          { name: "Biological Techniques" },
          { name: "Co-Lab" }
        ],
        edges: [

          { source: 0, target: 1},
          { source: 0, target: 11},
          { source: 0, target: 7},
          { source: 0, target: 10},
          { source: 0, target: 15},
          { source: 0, target: 19},
          { source: 0, target: 22},
          { source: 0, target: 4},
          { source: 0, target: 3},
          { source: 0, target: 8},
          { source: 0, target: 16},
          { source: 0, target: 18},
          { source: 0, target: 19},
          { source: 0, target: 20},
          { source: 0, target: 21},
          { source: 0, target: 22},

          { source: 1, target: 0},
          { source: 1, target: 23},
          { source: 1, target: 2},

          { source: 2, target: 1},
          { source: 2, target: 11},
          { source: 2, target: 9},
          { source: 2, target: 11},
          { source: 2, target: 12},
          { source: 2, target: 23},
          { source: 2, target: 5},
          { source: 2, target: 8},
          { source: 2, target: 19},

          { source: 3, target: 0},

          { source: 4, target: 0},

          { source: 5, target: 2},

          { source: 6, target: 0},
          { source: 6, target: 2},
          { source: 6, target: 11},

          { source: 7, target: 0},

          { source: 8, target: 0},
          { source: 8, target: 2},
          { source: 8, target: 11},

          { source: 9, target: 2},
          { source: 9, target: 12},

          { source: 10, target: 0},

          { source: 11, target: 0},
          { source: 11, target: 2},
          { source: 11, target: 17},
          { source: 11, target: 6},
          { source: 11, target: 12},
          { source: 11, target: 24},

          { source: 12, target: 2},
          { source: 12, target: 9},
          { source: 12, target: 11},
          { source: 12, target: 13},
          { source: 12, target: 14},

          { source: 13, target: 12},
          { source: 13, target: 14},

          { source: 14, target: 12},
          { source: 14, target: 13},

          { source: 15, target: 0},

          { source: 16, target: 0},

          { source: 17, target: 11},

          { source: 18, target: 0},

          { source: 19, target: 0},
          { source: 19, target: 2},

          { source: 20, target: 0},

          { source: 21, target: 0},

          { source: 22, target: 0},

          { source: 23, target: 1},
          { source: 23, target: 2},
          { source: 23, target: 11},

          { source: 24, target: 1},
          { source: 24, target: 11}

        ]
      };

      //Initialize a default force layout, using the nodes and edges in dataset
      var force = d3.layout.force()
        .nodes(dataset.nodes)
        .links(dataset.edges)
        .size([w, h])
        .linkDistance([80])
        .charge([-1000])
        .start();

      //Create SVG element
      var svg = d3.select(".intro-graphic")
        .append("svg")
        .attr("width", w)
        .attr("height", h)
        .append('g');

      //Create edges as lines
      var edges = svg.selectAll("line")
        .data(dataset.edges)
        .enter()
        .append("line")
        .attr('target', function(d){return JSON.stringify(d.target.index)})
        .attr('source', function(d){return JSON.stringify(d.source.index)})
        .style({"stroke": function(d,i){
          return "#ccc";
        }})
        .style("stroke-width", .1);

      // Create nodes as circles
      var nodes = svg.selectAll("circle")
        .data(dataset.nodes)
        .enter()
        .append("circle")
        .attr("aid", function(d,i){return i;})
        .style({"fill":"white","stroke":'#ccc'})
        .attr("r", 6)
        .call(force.drag);

      var titles = svg.selectAll("text")
        .data(dataset.nodes)
        .enter()
        .append("text")
        .text(function(d,i) {return dataset.nodes[i].name})
        .attr("aid",function(d,i){return i;})
        .attr("font-family", "helvetica")
        .attr("font-size", "8px")
        .attr("fill", "gray")
        .call(force.drag);


      //Every time the simulation "ticks", this will be called
      force.on("tick", function() {

        edges.attr("x1", function(d) { return d.source.x; })
           .attr("y1", function(d) { return d.source.y; })
           .attr("x2", function(d) { return d.target.x; })
           .attr("y2", function(d) { return d.target.y; });

        nodes.attr("cx", function(d) { return d.x; })
           .attr("cy", function(d) { return d.y; });

        titles.attr("x", function(d) { return d.x + 16;})
           .attr("y", function(d) { return d.y + 5;});

      });

      // tag selection
;
