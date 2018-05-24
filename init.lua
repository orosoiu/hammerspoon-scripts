-- Config section
-- mouse pointer indicator: show a circle ripple effect around the mouse cursor 
-- when holding a modifier key while clicking the left mouse button
mousePointerIndicator_enabled = true
mousePointerIndicator_noOfCircles = 6  -- recommended to keep this below 10
mousePointerIndicator_circleColor_red = 250
mousePointerIndicator_circleColor_green = 0
mousePointerIndicator_circleColor_blue = 0
mousePointerIndicator_circleColor_alpha = .8     -- between 0 and 1
mousePointerIndicator_circleColor_filled = false
mousePointerIndicator_circleColor_fill_red = 255
mousePointerIndicator_circleColor_fill_green = 0
mousePointerIndicator_circleColor_fill_blue = 0
mousePointerIndicator_circleColor_fill_alpha = .2     -- between 0 and 1

function mousePointerIndicator()
    local filled = false
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    local circles = {}
    for circleNo = 1,mousePointerIndicator_noOfCircles do
        hs.timer.doAfter(.06*circleNo, function() 
            local offset = 10+circleNo*circleNo*2
            circles["mouseCircle" .. circleNo] = hs.drawing.circle(hs.geometry.rect(mousepoint.x-offset/2, mousepoint.y-offset/2, offset, offset))
            circles["mouseCircle" .. circleNo]:setStrokeColor({
                ["red"] = mousePointerIndicator_circleColor_red/255,
                ["blue"] = mousePointerIndicator_circleColor_blue/255,
                ["green"] = mousePointerIndicator_circleColor_green/255,
                ["alpha"] = mousePointerIndicator_circleColor_alpha
            })
            circles["mouseCircle" .. circleNo]:setFill(mousePointerIndicator_circleColor_filled)
            circles["mouseCircle" .. circleNo]:setFillColor({
                ["red"] = mousePointerIndicator_circleColor_fill_red/255,
                ["blue"] = mousePointerIndicator_circleColor_fill_blue/255,
                ["green"] = mousePointerIndicator_circleColor_fill_green/255,
                ["alpha"] = mousePointerIndicator_circleColor_fill_alpha
            })
            circles["mouseCircle" .. circleNo]:setStrokeWidth(circleNo/2)
            circles["mouseCircle" .. circleNo]:show()
            hs.timer.doAfter(.18, function() 
                circles["mouseCircle" .. circleNo]:delete() 
                circles["mouseCircle" .. circleNo] = nil 
            end)
        end)
    end
end

if mousePointerIndicator_enabled then
    eventtapLeftMouseDown = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown }, function(event)
        mousePointerIndicator()
        return false
    end)
    eventtapLeftMouseDown:start()
end
