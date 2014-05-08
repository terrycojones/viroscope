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

ViroscopeException = (message) ->
   this.message = message
   this.name = 'ViroscopeException'


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

    addChild: (child) =>
        @children.push child

    ancestors: =>
        result = []
        node = @
        while node.parent
            result.push node
            node = node.parent
        result.reverse()

    computeAllProperties: () =>
        if @allProperties
            return
        else
            @allProperties = {}
            for ancestor in @ancestors()
                if ancestor.properties
                    angular.extend @allProperties, ancestor.properties

    format: () =>
        @computeAllProperties()
        return {
            ancestry: =>
                #if @name isnt 'Unassigned'
                (ancestor.name for ancestor in @ancestors()).filter((name) -> name isnt 'Unassigned').join(' / ')
            genome: =>
                # TODO: Remove
                if not @allProperties.genome?
                    return 'not set yet'
                sense = []
                if @allProperties.genome.positive
                    sense.push '+'
                if @allProperties.genome.negative
                    sense.push '+'
                if @allProperties.genome.ambisense
                    sense.push '+/-'
                @allProperties.genome.type + (if sense.length then ' (' + sense.join(', ') + ')' else '')
            envelope: =>
                @allProperties.envelope
            morphology: =>
                # TODO: Fix the case where there is no morphology.
                return @allProperties.morphology ? ''
            genomeSize: =>
                if @allProperties.genomeSize?
                    if typeof @allProperties.genomeSize == 'number'
                        @allProperties.genomeSize + ' bp'
                    else
                        @allProperties.genomeSize[0] + '-' + @allProperties.genomeSize[1] + ' bp'
                else
                    'nothing'
            virionSize: =>
                if @allProperties.virionSize?
                    if typeof @allProperties.virionSize == 'number'
                        @allProperties.virionSize + ' bp'
                    else
                        @allProperties.virionSize[0] + '-' + @allProperties.virionSize[1] + ' nm'
                else
                    'nada'
            host: =>
                if @allProperties.host?
                    (@hostAbbrevs[host] for host in @allProperties.host).join(', ')
                else
                    'no host...'

        }

    addMorphologyKeywords: () =>
        recurse = (node) ->
            if node.properties.morphology and not node.properties.morphologyKeywords
                node.properties.morphologyKeywords = node.properties.morphology
            recurse child for child in node.children
        recurse @

    invertHidden: () =>
        # Invert the hidden status of this node, and set the hidden status
        # of its children to the same value.
        hidden = not @hidden
        recurse = (node) ->
            node.hidden = hidden
            recurse child for child in node.children
        recurse @

    showAccordingToAttributes: ($scope) =>
        @computeAllProperties()

        return (
            (
                $scope.searchText.length == 0 or @name.toLowerCase().indexOf($scope.searchText) > -1
            ) and (
                # Envelope
                @allProperties.envelope == undefined or # TODO: remove this line.
                $scope.envelope.enveloped and @allProperties.envelope or
                $scope.envelope.notEnveloped and not @allProperties.envelope
            ) and (
                # Shape
                @allProperties.morphologyKeywords == undefined or # TODO: remove this line.
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
                # Host
                @allProperties.host == undefined or # TODO: remove this line.
                $scope.host.algae         and 'Al' in @allProperties.host or
                $scope.host.archaea       and 'Ar' in @allProperties.host or
                $scope.host.bacteria      and 'B'  in @allProperties.host or
                $scope.host.fungi         and 'F'  in @allProperties.host or
                $scope.host.invertebrates and 'I'  in @allProperties.host or
                $scope.host.protozoa      and 'P'  in @allProperties.host or
                $scope.host.vertebrates   and 'V'  in @allProperties.host
            ) and (
                # Genome
                @allProperties.genome == undefined or # TODO: remove this line.
                $scope.genome.ssDNA       and @allProperties.genome.type == 'ssDNA' or
                $scope.genome.dsDNA       and @allProperties.genome.type == 'dsDNA' or
                $scope.genome.ssRNA       and @allProperties.genome.type == 'ssRNA' or
                $scope.genome.dsRNA       and @allProperties.genome.type == 'dsRNA' or
                $scope.genome.positive    and @allProperties.genome.positive or
                $scope.genome.negative    and @allProperties.genome.negative or
                $scope.genome.ambisense   and @allProperties.genome.ambisense
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
                      # the lack of one doesn't indicate anything.
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

        width = 600
        height = 200

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

    rescale: () =>
        trans = d3.event.translate
        scale = d3.event.scale
        # console.log 'rescale:', trans, scale
        @vis.attr('transform', "translate(#{trans}) scale(#{scale})")

    mousedown: () =>
        # console.log 'mouse down', @rescale
        # console.log 'zoom', d3.behavior.zoom().on('zoom')
        # Allow panning if nothing is selected.
        @vis.call(d3.behavior.zoom().on('zoom', @rescale))

    mousemove: () =>
        # console.log 'mouse move'

    mouseup: () =>
        # console.log 'mouse up'

    mousedown: () =>
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

    keydown: () =>
        # console.log 'key:', d3.event.keyCode
        if not @selectedNode
            return

        switch d3.event.keyCode
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
        console.log 'Refresh'
        if data
            @root = data
            @$scope = $scope
            console.log 'Root', @root
            console.log 'Scope', @$scope
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

addProperties = (properties, tree) ->
    recurse = (propertyNode, treeNode) ->
        treeNode.properties = propertyNode.properties
        if propertyNode.children
            if not treeNode.children
                throw new ViroscopeException("Tree ran out of children before properties did")
            for name of propertyNode.children
                if name not of treeNode.children
                    throw new ViroscopeException("Could not find name #{name} in tree")
                recurse propertyNode.children[name], treeNode.children[name]
    recurse properties, tree

convertToChildLists = (tree) ->
    # In each node of tree, children are kept in an object keyed by name.
    # Convert the dict to a list of objects, and put a name attribute into
    # each object. This makes for easier processing in the Viroscope class.
    convertNodeToList = (name, node, level, parent) ->
        properties = node.properties ? {}
        if node.typeSpecies?
            properties.typeSpecies = node.typeSpecies
        result = new Node(name, parent, properties, level)
        for childName of node.children
            result.addChild(
                convertNodeToList(childName, node.children[childName], level + 1, result))
        result
    convertNodeToList 'root', tree, 0, null

initializeScope = ($scope) ->
    # root, order, family, subfamily, genus, species.
    # In $scope.taxonomy, values are true if that level of the
    # taxonomy should be shown.
    $scope.taxonomy = [false, true, true, false, false, false]
    $scope.displayUnassignedNodes = [false]
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
    $scope.envelope =
        enveloped: true
        notEnveloped: true
    $scope.host =
        algae: true
        archaea: true
        bacteria: true
        fungi: true
        invertebrates: true
        protozoa: true
        vertebrates: true
    $scope.genome =
        ssDNA: true
        dsDNA: true
        ssRNA: true
        dsRNA: true
        positive: true
        negative: true
        ambisense: true
    $scope.setAll = (attr, value) ->
        for name of $scope[attr]
            $scope[attr][name] = value
        $scope.viroscope.refresh()

    $scope.unlockInfoNode = ->
        $scope.infoNodeLocked = false

    $scope.searchText = ''
    $scope.search = ->
        console.log 'searching for', $scope.searchText
        $scope.viroscope.refresh()

angular.module('viroscope-app')
    .controller('MainCtrl', ($scope, $http) ->

        $scope.viroscope = new Viroscope
        initializeScope $scope

        d = $.when $.getJSON('/api/taxonomy'), $.getJSON('/api/properties')
        d.done (taxonomyXHR, propertiesXHR) ->
            taxonomy = taxonomyXHR[0]
            properties = propertiesXHR[0]
            addProperties properties, taxonomy
            root = convertToChildLists taxonomy
            root.addMorphologyKeywords()
            $scope._converted = root # Used in testing
            $scope.viroscope.refresh root, $scope
    )
