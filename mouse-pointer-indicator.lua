-- mouse pointer indicator: show a circle ripple effect around the mouse cursor 
-- while clicking the left mouse button

-- config section
local animation = "sonar-out" -- valid values: sonar-out, sonar-in
local noOfCircles = 6 -- recommended to keep this below 10
local strokeColor = {
    ["rainbow"] = false, -- set to true to use random colors instead of colors defined below
    ["red"] = 192, -- between 0 and 255
    ["green"] = 41, -- between 0 and 255
    ["blue"] = 66, -- between 0 and 255
    ["alpha"] = .8 -- between 0 and 1
}
local fillColor = {
    ["enabled"] = false,
    ["red"] = 236, -- between 0 and 255
    ["green"] = 208, -- between 0 and 255
    ["blue"] = 120, -- between 0 and 255
    ["alpha"] = .2 -- between 0 and 1
}

-- metadata section
local animationSteps = {
    ["start"] = {
        ["sonar-in"] = noOfCircles,
        ["sonar-out"] = 1
    },
    ["end"] = {
        ["sonar-in"] = 1,
        ["sonar-out"] = noOfCircles
    },
    ["increment"] = {
        ["sonar-in"] = -1,
        ["sonar-out"] = 1
    }
}

function showMousePointerIndicator()
    local mousepoint = hs.mouse.getAbsolutePosition()
    local circles = {}
    local currentStep = 1
    for step = animationSteps["start"][animation], animationSteps["end"][animation], animationSteps["increment"][animation] do
        hs.timer.doAfter(.06 * currentStep, function()
            local offset = 10 + (step * step * 2)
            local coordX = mousepoint.x - (offset / 2)
            local coordY = mousepoint.y - (offset / 2)

            circles["mouseCircle" .. step] = hs.drawing.circle(hs.geometry.rect(coordX, coordY, offset, offset))
            circles["mouseCircle" .. step]:setStrokeColor({
                ["red"] = fif(strokeColor["rainbow"], math.random(), strokeColor["red"] / 255),
                ["green"] = fif(strokeColor["rainbow"], math.random(), strokeColor["green"] / 255),
                ["blue"] = fif(strokeColor["rainbow"], math.random(), strokeColor["blue"] / 255),
                ["alpha"] = strokeColor["alpha"]
            })
            circles["mouseCircle" .. step]:setStrokeWidth(step / 2)

            circles["mouseCircle" .. step]:setFill(fillColor["enabled"])
            if fillColor["enabled"] then
                circles["mouseCircle" .. step]:setFillColor({
                    ["red"] = fillColor["red"] / 255,
                    ["green"] = fillColor["green"] / 255,
                    ["blue"] = fillColor["blue"] / 255,
                    ["alpha"] = fillColor["alpha"]
                })
            end

            circles["mouseCircle" .. step]:show()

            hs.timer.doAfter(.18, function()
                circles["mouseCircle" .. step]:delete()
                circles["mouseCircle" .. step] = nil
            end)
        end)
        currentStep = currentStep + 1
    end
end

eventtapLeftMouseDown = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown },
    function(_)
        showMousePointerIndicator()
        return false
    end)
eventtapLeftMouseDown:start()
