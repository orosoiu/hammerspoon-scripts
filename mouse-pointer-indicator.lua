-- mouse pointer indicator: show a circle ripple effect around the mouse cursor 
-- when holding a modifier key while clicking the left mouse button

-- config section
local mousePointerIndicator_noOfCircles = 6 -- recommended to keep this below 10
local mousePointerIndicator_strokeColor_red = 192
local mousePointerIndicator_strokeColor_green = 41
local mousePointerIndicator_strokeColor_blue = 66
local mousePointerIndicator_strokeColor_alpha = .8 -- between 0 and 1
local mousePointerIndicator_filled = false
local mousePointerIndicator_fillColor_red = 236
local mousePointerIndicator_fillColor_green = 208
local mousePointerIndicator_fillColor_blue = 120
local mousePointerIndicator_fillColor_alpha = .2 -- between 0 and 1

function mousePointerIndicator()
    local mousepoint = hs.mouse.getAbsolutePosition()
    local circles = {}

    for circleNo = 1, mousePointerIndicator_noOfCircles do
        hs.timer.doAfter(.06 * circleNo, function()
            local offset = 10 + (circleNo * circleNo * 2)
            local coordX = mousepoint.x - (offset / 2)
            local coordY = mousepoint.y - (offset / 2)

            circles["mouseCircle" .. circleNo] = hs.drawing.circle(hs.geometry.rect(coordX, coordY, offset, offset))
            circles["mouseCircle" .. circleNo]:setStrokeColor({
                ["red"] = mousePointerIndicator_strokeColor_red / 255,
                ["blue"] = mousePointerIndicator_strokeColor_blue / 255,
                ["green"] = mousePointerIndicator_strokeColor_green / 255,
                ["alpha"] = mousePointerIndicator_strokeColor_alpha
            })
            circles["mouseCircle" .. circleNo]:setStrokeWidth(circleNo / 2)

            circles["mouseCircle" .. circleNo]:setFill(mousePointerIndicator_filled)
            if mousePointerIndicator_filled then
                circles["mouseCircle" .. circleNo]:setFillColor({
                    ["red"] = mousePointerIndicator_fillColor_red / 255,
                    ["blue"] = mousePointerIndicator_fillColor_blue / 255,
                    ["green"] = mousePointerIndicator_fillColor_green / 255,
                    ["alpha"] = mousePointerIndicator_fillColor_alpha
                })
            end

            circles["mouseCircle" .. circleNo]:show()

            hs.timer.doAfter(.18, function()
                circles["mouseCircle" .. circleNo]:delete()
                circles["mouseCircle" .. circleNo] = nil
            end)
        end)
    end
end

eventtapLeftMouseDown = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown },
    function(_)
        mousePointerIndicator()
        return false
    end)
eventtapLeftMouseDown:start()
