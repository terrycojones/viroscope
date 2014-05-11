'use strict'

ORDER = 1
FAMILY = 2
SUBFAMILY = 3
GENUS = 4
SPECIES = 5

# Colors from http://colorbrewer2.org/
# COLORS = ['',   '#253494', '#2c7fb8', '#41b6c4', '#a1dab4', '#ffffcc']
COLORS = ['red',   '#253494', '#2c7fb8', '#41b6c4', '#a1dab4', '#ffffcc']

LEVELS = ['root', 'order', 'family', 'sub-family', 'genus', 'species']


class Node
    constructor: (@name, @parent, @properties, @level) ->
        @children = []
        @hidden = false
        @allProperties = null
        @hostAbbrevs =
            Al: 'Algae'
            Ar: 'Archaea'
            B: 'Bacteria'
            F: 'Fungi'
            I: 'Invertebrates'
            P: 'Protozoa'
            V: 'Vertebrates'

        @format =
            ancestry: =>
                (ancestor.name for ancestor in @ancestors()).filter((name) -> name isnt 'Unassigned').join(' / ')
            links: =>
                return @allProperties.links ? []
            genome: =>
                # TODO: Remove
                if not @allProperties.genome?
                    return 'not set yet'
                sense = []
                if @allProperties.genome.positive
                    sense.push '+'
                if @allProperties.genome.negative
                    sense.push '-'
                if @allProperties.genome.ambisense
                    sense.push '+/-'
                @allProperties.genome.type + (if sense.length then ' (' + sense.join(', ') + ')' else '')
            envelope: =>
                if @allProperties.envelope then 'yes' else 'no'
            morphology: =>
                # TODO: Fix the case where there is no morphology.
                return @allProperties.morphology ? ''
            genomeLength: =>
                if @allProperties.genome.lengthDescription?
                    @allProperties.genome.lengthDescription
                else if angular.isArray @allProperties.genome.length
                    @allProperties.genome.length[0] + '-' + @allProperties.genome.length[1]
                else
                    ''
            genomeConfiguration: =>
                if @allProperties.genome?.configurationDescription?
                    @allProperties.genome.configurationDescription
                else
                    ''
            virionDescription: =>
                if @allProperties.virionDescription?
                    @allProperties.virionDescription
                else if angular.isArray @allProperties.virionSize
                    @allProperties.virionSize[0] + '-' + @allProperties.virionSize[1]
                else
                    ''
            host: =>
                if @allProperties.host?
                    (@hostAbbrevs[host] for host in @allProperties.host).join(', ')
                else
                    ''

    addChild: (child) =>
        @children.push child

    ancestors: =>
        result = []
        node = @
        while node.parent
            result.push node
            node = node.parent
        result.reverse()

    computeFullText: =>
        # The fullText property is used in search.
        full = [ @name ]
        for property of @allProperties
            if property != 'genome'
                if typeof @allProperties[property] != 'boolean'
                    full.push JSON.stringify(@allProperties[property])
        if @allProperties.genome
            for property of @allProperties.genome
                if typeof @allProperties.genome[property] != 'boolean'
                    full.push JSON.stringify(@allProperties.genome[property])
        full.push JSON.stringify(@format.host())
        full.join(' ').toLowerCase()

    computeAllProperties: =>
        @allProperties = {}
        if @parent and @parent.allProperties
            angular.extend @allProperties, @parent.allProperties
        if @properties
            angular.extend @allProperties, @properties
        @fullText = @computeFullText()

        for child in @children
            child.computeAllProperties()

    addMorphologyKeywords: =>
        recurse = (node) ->
            if node.properties.morphology and not node.properties.morphologyKeywords
                node.properties.morphologyKeywords = node.properties.morphology
            recurse child for child in node.children
        recurse @

    invertHidden: =>
        # Invert the hidden status of this node, and set the hidden status
        # of its children to the same value.
        hidden = not @hidden
        recurse = (node) ->
            node.hidden = hidden
            recurse child for child in node.children
        recurse @

    showAccordingToAttributes: ($scope) =>
        return (
            (
                $scope.searchText.length == 0 or @fullText.indexOf($scope.searchText.toLowerCase()) > -1
            ) and (
                # Envelope.
                @allProperties.envelope is undefined or
                $scope.envelope.enveloped and @allProperties.envelope or
                $scope.envelope.notEnveloped and not @allProperties.envelope
            ) and (
                # Morphology.
                @allProperties.morphologyKeywords is undefined or
                $scope.morphology.allantoid         and @allProperties.morphologyKeywords.indexOf('allantoid') > -1 or
                $scope.morphology.bacilliform       and @allProperties.morphologyKeywords.indexOf('bacilliform') > -1 or
                $scope.morphology.bottleShaped      and @allProperties.morphologyKeywords.indexOf('bottle-shaped') > -1 or
                $scope.morphology.bulletShaped      and @allProperties.morphologyKeywords.indexOf('bullet-shaped') > -1 or
                $scope.morphology.coiled            and @allProperties.morphologyKeywords.indexOf('coiled') > -1 or
                $scope.morphology.dropletShaped     and @allProperties.morphologyKeywords.indexOf('droplet-shaped') > -1 or
                $scope.morphology.filamentous       and @allProperties.morphologyKeywords.indexOf('filamentous') > -1 or
                $scope.morphology.icosahedral       and @allProperties.morphologyKeywords.indexOf('icosahedral') > -1 or
                $scope.morphology.icosahedralHead   and @allProperties.morphologyKeywords.indexOf('icosahedral head') > -1 or
                $scope.morphology.icosahedralCore   and @allProperties.morphologyKeywords.indexOf('icosahedral core') > -1 or
                $scope.morphology.rnp               and @allProperties.morphologyKeywords.indexOf('RNP complex') > -1 or
                $scope.morphology.lemonShaped       and @allProperties.morphologyKeywords.indexOf('lemon-shaped') > -1 or
                $scope.morphology.ovoidal           and @allProperties.morphologyKeywords.indexOf('ovoidal') > -1 or
                $scope.morphology.pleomorphic       and @allProperties.morphologyKeywords.indexOf('pleomorphic') > -1 or
                $scope.morphology.prolateEllipsoid  and @allProperties.morphologyKeywords.indexOf('prolate ellipsoid') > -1 or
                $scope.morphology.pseudoIcosahedral and @allProperties.morphologyKeywords.indexOf('pseudo-icosahedral') > -1 or
                $scope.morphology.quasiSpherical    and @allProperties.morphologyKeywords.indexOf('quasi-spherical') > -1 or
                $scope.morphology.rodShaped         and @allProperties.morphologyKeywords.indexOf('rod-shaped') > -1 or
                $scope.morphology.shortTail         and @allProperties.morphologyKeywords.indexOf('short tail') > -1 or
                $scope.morphology.spherical         and @allProperties.morphologyKeywords.indexOf('spherical') > -1 or
                $scope.morphology.tail              and @allProperties.morphologyKeywords.indexOf('tail') > -1 or
                $scope.morphology.twoTailed         and @allProperties.morphologyKeywords.indexOf('two-tailed') > -1
            ) and (
                # Host.
                @allProperties.host is undefined or
                $scope.host.algae         and 'Al' in @allProperties.host or
                $scope.host.archaea       and 'Ar' in @allProperties.host or
                $scope.host.bacteria      and 'B'  in @allProperties.host or
                $scope.host.fungi         and 'F'  in @allProperties.host or
                $scope.host.invertebrates and 'I'  in @allProperties.host or
                $scope.host.plants        and 'P'  in @allProperties.host or
                $scope.host.protozoa      and 'Pr' in @allProperties.host or
                $scope.host.vertebrates   and 'V'  in @allProperties.host
            ) and (
                # Genome.
                @allProperties.genome?.type is undefined or
                $scope.genome.ssDNAPositive       and @allProperties.genome.type == 'ssDNA' and @allProperties.genome.positive or
                $scope.genome.ssDNANegative       and @allProperties.genome.type == 'ssDNA' and @allProperties.genome.negative or
                $scope.genome.ssDNANegativeOrAmbi and @allProperties.genome.type == 'ssDNA' and (@allProperties.genome.negative or @allProperties.genome.ambisense) or
                $scope.genome.ssDNAAmbi           and @allProperties.genome.type == 'ssDNA' and @allProperties.genome.ambisense or
                $scope.genome.dsDNA               and @allProperties.genome.type == 'dsDNA' or
                $scope.genome.dsDNART             and @allProperties.genome.type == 'dsDNA' and @allProperties.genome.RT or
                $scope.genome.ssRNAPositive       and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.positive or
                $scope.genome.ssRNARTPositive     and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.RT and @allProperties.genome.positive or
                $scope.genome.ssRNANegative       and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.negative or
                $scope.genome.ssRNAAmbi           and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.ambisense or
                $scope.genome.dsRNA               and @allProperties.genome.type == 'dsRNA'
            ) and (
                # Baltimore.
                @allProperties.genome?.type is undefined or
                $scope.genome.baltimore[0] and @allProperties.genome.type == 'dsDNA' and not @allProperties.genome.RT or
                $scope.genome.baltimore[1] and @allProperties.genome.type == 'ssDNA' or
                $scope.genome.baltimore[2] and @allProperties.genome.type == 'dsRNA' or
                $scope.genome.baltimore[3] and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.positive and not @allProperties.genome.RT or
                $scope.genome.baltimore[4] and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.negative or
                $scope.genome.baltimore[5] and @allProperties.genome.type == 'ssRNA' and @allProperties.genome.positive and @allProperties.genome.RT or
                $scope.genome.baltimore[6] and @allProperties.genome.type == 'dsDNA' and @allProperties.genome.RT
            ) and (
                # Genome organization.
                @allProperties.genome?.configurationDescription is undefined or
                $scope.genome.linear    and @allProperties.genome.configurationDescription.toLowerCase().indexOf('linear') > -1 or
                $scope.genome.circular  and @allProperties.genome.configurationDescription.toLowerCase().indexOf('circular') > -1 or
                $scope.genome.coiled    and @allProperties.genome.configurationDescription.toLowerCase().indexOf('coiled') > -1 or
                $scope.genome.segmented and @allProperties.genome.configurationDescription.toLowerCase().indexOf('segments') > -1
            ) and (
                # Virion size slider. Return true on any overlap.
                @allProperties.virionSize[1] >= $scope.morphology.sliderMin and
                @allProperties.virionSize[0] <= $scope.morphology.sliderMax
            ) and (
                # Genome length slider. Return true on any overlap.
                @allProperties.genome.length[1] >= $scope.genome.sliderMin and
                @allProperties.genome.length[0] <= $scope.genome.sliderMax
            )
        )

    flatten: ($scope) =>
        nodes = []
        links = []
        i = 0
        recurse = (node, parent) =>
            if not node.id
                node.id = i++
            hidden = (node.hidden or
                      not node.showAccordingToAttributes($scope) or
                      # Always hide unassigned sub-family nodes, they're
                      # never of interest as sub-families are optional and
                      # the lack of one doesn't indicate anything
                      # interesting.
                      (node.level == SUBFAMILY and node.name == 'Unassigned') or
                      (not $scope.displayUnassignedNodes[0] and node.name == 'Unassigned') or
                      not $scope.taxonomy[node.level])
            if not hidden
                nodes.push node
                if parent?
                    links.push {
                        level: node.level
                        source: parent
                        target: node
                    }
            for child in node.children
                recurse(child, (if hidden then parent else node))
        recurse @, null
        return {
            nodes: nodes
            links: links
        }


class Viroscope
    constructor: ->
        @$scope = null
        @root = null
        @selectedNode = null

        width = 1050
        height = 350

        # aspect = width / height
        # chart = $ '#viroscope'
        # d3.select(window).on('resize', ->
        #     targetWidth = chart.parent().width()
        #     chart.attr 'width', targetWidth
        #     chart.attr 'height', targetWidth / aspect
        # )

        @force = d3.layout.force()
            .size([width, height])
            .charge(-150)
            #.gravity(0.2)
            .linkDistance(80)
            .on('tick', @tick)

        # @force.drag()
        #     .on('dragstart', @dragstart)

        svg = d3.select('#viroscope')
            .append('svg')
                .attr('class', 'main-view')
                .attr('width', width)
                .attr('height', height)
                .attr('width', '100%')
                .attr('height', '85%')
                .attr('viewBox', '0 0 ' + width + ' ' + height )
                .attr('preserveAspectRatio', 'xMidYMid')
                .attr('pointer-events', 'all')
            .call(d3.behavior.zoom().on('zoom', @rescale))

        @vis = svg
            # .append('svg:g')
            # .call(d3.behavior.zoom().on('zoom', @rescale))
            # .on('dblclick.zoom', null)
            .append('svg:g')
                .on('mousedown', @mousedown)
                .on('mousemove', @mousemove)
                .on('mouseup', @mouseup)
                .on('mousedown', @mousedown)

        # @vis.append('svg:rect')
        #     .attr('width', width)
        #     .attr('height', height)
        #     .attr('fill', 'white')

        @link = @vis.selectAll('.link')
        @node = @vis.selectAll('.node')

        d3.select(window).on('keydown', @keydown)

    rescale: =>
        trans = d3.event.translate
        scale = d3.event.scale
        # console.log 'rescale:', trans, scale
        @vis.attr('transform', "translate(#{trans}) scale(#{scale})")

    mousedown: =>
        # console.log 'mouse down', @rescale
        # console.log 'zoom', d3.behavior.zoom().on('zoom')
        # Allow panning if nothing is selected.
        @vis.call(d3.behavior.zoom().on('zoom', @rescale))

    mousemove: =>
        # console.log 'mouse move'

    mouseup: =>
        # console.log 'mouse up'

    mousedown: =>
        # console.log 'mouse down'

    mouseOffNode: (d) =>
        # console.log 'mouse off node'
        @selectedNode = null
        unless @$scope.infoNodeLocked
            @$scope.infoNode = null
            @$scope.$apply()

    mouseOverNode: (d) =>
        if d.name isnt 'root'
            @selectedNode = d
            unless @$scope.infoNodeLocked
                @$scope.infoNode = d
                @$scope.$apply()

    # Toggle children on click.
    click: (d) =>
        # console.log 'click'
        if d3.event.defaultPrevented
            # console.log 'Ignore dragging'
            # Ignore dragging.
            return
        child.invertHidden() for child in d.children
        @refresh()

    tick: =>
        @link.attr('x1', (d) -> d.source.x)
          .attr('y1', (d) -> d.source.y)
          .attr('x2', (d) -> d.target.x)
          .attr('y2', (d) -> d.target.y)
        @node.attr('transform', (d) -> "translate(#{d.x}, #{d.y})")

    dblclick: (d) ->
        d3.select(this).classed('fixed', d.fixed = false)

    dragstart: (d) ->
        # d3.select(this).classed('fixed', d.fixed = true)

    keydown: =>
        # console.log 'key:', d3.event.keyCode
        if not @selectedNode
            return

        switch d3.event.keyCode
            when 65 # a = all properties
                console.log 'Selected node', @selectedNode
            when 67 # c = click
                child.invertHidden() for child in @selectedNode.children
                @refresh()
            when 76 # l = lock
                @$scope.infoNode = @selectedNode
                @$scope.infoNodeLocked = true
                @$scope.$apply()
            when 80 # p = pin
                @selectedNode.fixed = true
            when 82 # r = release (from being pinned)
                @selectedNode.fixed = false
            when 85 # u = unlock
                @$scope.infoNodeLocked = false
                @$scope.infoNode = @selectedNode
                @$scope.$apply()

    getCounts: (nodes) ->
        # Calculate how many of each level (order, family, etc) we are
        # displaying.
        result = [0, 0, 0, 0, 0, 0]
        for node in nodes
            if node.name != 'Unassigned'
                result[node.level]++
        @$scope.counts = result

    refresh: (data, $scope) =>
        if data
            @root = data
            @$scope = $scope
        f = @root.flatten @$scope
        nodes = f.nodes
        links = f.links
        @getCounts nodes
        @force.nodes(nodes).links(links)

        # Update links.
        @link = @link.data(links)
        @link.exit().remove()
        @link.enter().insert('line', '.node').attr('class', 'link')

        # Update nodes.
        @node = @node.data(nodes, (d) -> d.id)
            .call(@force.drag)
        @node.exit().remove()

        nodeEnter = @node.enter().append('g')
            .attr('class', 'node')
            # .on('dblclick', dblclick)

        nodeEnter.append('circle')
            .attr('r', 6)
            .on('click', @click)
            .on('mouseover', @mouseOverNode)
            .on('mouseout', @mouseOffNode)

        nodeEnter.append('text')
            .attr('dy', '1.5em')
            .text((d) ->
                if d.name == 'Unassigned'
                    LEVELS[d.level] + ' not assigned'
                else
                    d.name
            )

        @node.select('circle')
            .style('fill', (d) -> COLORS[d.level])

        if d3.event
            # prevent browser's default behavior
            d3.event.preventDefault()

        @force.start()


convertToChildLists = (tree) ->
    # In each node of tree, children are kept in an object keyed by name.
    # Convert the dict to a list of objects, and put a name attribute into
    # each object. This makes for easier processing in the Viroscope class.
    convertNodeToList = (name, node, level, parent) ->
        properties = node.properties ? {}
        newNode = new Node(name, parent, properties, level)
        if level != SPECIES
            nextLevel = LEVELS[level + 1]
            for childName of node[nextLevel]
                newNode.addChild(
                    convertNodeToList(childName, node[nextLevel][childName], level + 1, newNode))
        newNode
    convertNodeToList 'root', tree, 0, null

initializeScope = ($scope) ->
    # root, order, family, subfamily, genus, species.
    # In $scope.taxonomy, values are true if that level of the
    # taxonomy should be shown.
    $scope.taxonomy = [true, true, true, true, false, false]
    $scope.searchText = ''
    $scope.displayUnassignedNodes = [true]
    $scope.infoNode = null
    $scope.infoNodeLocked = false
    $scope.counts = [0, 0, 0, 0, 0, 0]
    $scope.morphology =
        allantoid: true
        bacilliform: true
        bottleShaped: true
        bulletShaped: true
        coiled: true
        dropletShaped: true
        filamentous: true
        icosahedral: true
        icosahedralHead: true
        icosahedralCore: true
        rnp: true
        lemonShaped: true
        ovoidal: true
        pleomorphic: true
        prolateEllipsoid: true
        pseudoIcosahedral: true
        quasiSpherical: true
        rodShaped: true
        shortTail: true
        spherical: true
        tail: true
        twoTailed: true
        minWidth: 1 # Arbitrary - set after we receive all data.
        maxWidth: 100 # Arbitrary - set after we receive all data.
        sliderMin: 1 # Arbitrary - set after we receive all data.
        sliderMax: 100 # Arbitrary - set after we receive all data.
    $scope.envelope =
        enveloped: true
        notEnveloped: true
    $scope.host =
        algae: true
        archaea: true
        bacteria: true
        fungi: true
        invertebrates: true
        plants: true
        protozoa: true
        vertebrates: true
    $scope.genome =
        linear: true
        circular: true
        coiled: true
        segmented: true
        ssDNAPositive: true
        ssDNANegative: true
        ssDNANegativeOrAmbi: true
        ssDNAAmbi: true
        dsDNA: true
        dsDNART: true
        ssRNAPositive: true
        ssRNARTPositive: true
        ssRNANegative: true
        ssRNAAmbi: true
        dsRNA: true
        baltimore: [true, true, true, true, true, true, true]
        minWidth: 1 # Arbitrary - set after we receive all data.
        maxWidth: 100 # Arbitrary - set after we receive all data.
        sliderMin: 1 # Arbitrary - set after we receive all data.
        sliderMax: 100 # Arbitrary - set after we receive all data.

    $scope.setAll = (attr, value) ->
        for name of $scope[attr]
            $scope[attr][name] = value
        $scope.viroscope.refresh()

    $scope.unlockInfoNode = ->
        $scope.infoNodeLocked = false

angular.module('viroscope-app')
    .controller 'MainCtrl', ($scope, $http) ->

        $scope.viroscope = new Viroscope
        initializeScope $scope

        $http.get('/api/taxonomy').success (taxonomy) ->
            root = convertToChildLists taxonomy
            console.log 'root', root
            root.addMorphologyKeywords()
            root.computeAllProperties()
            $scope._converted = root # Used in testing

            $scope.morphology.minWidth = $scope.morphology.sliderMin = root.allProperties.virionSize[0]
            $scope.morphology.maxWidth = $scope.morphology.sliderMax = root.allProperties.virionSize[1]

            $scope.genome.minWidth = $scope.genome.sliderMin = root.allProperties.genome.length[0]
            $scope.genome.maxWidth = $scope.genome.sliderMax = root.allProperties.genome.length[1]

            # Watch the morphology slider.
            $scope.$watch 'morphology.sliderMax', ->
                $scope.viroscope.refresh()
            $scope.$watch 'morphology.sliderMin', ->
                $scope.viroscope.refresh()
            # Watch the genome length slider.
            $scope.$watch 'genome.sliderMax', ->
                $scope.viroscope.refresh()
            $scope.$watch 'genome.sliderMin', ->
                $scope.viroscope.refresh()

            $scope.viroscope.refresh root, $scope
