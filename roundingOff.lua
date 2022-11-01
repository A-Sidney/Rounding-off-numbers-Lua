print("Enter the number you want to round off")
local number = tonumber(io.read())
print("Enter the number of significant figures you wish to round off your number to.")
local sigFigure = tonumber(io.read())

local function roundOff(number, sigFigure)

    local function round(number)
        local answer = math.floor(number + 0.5)
        return answer
    end

    local function unitDec(number)
        local displacement = 0
        while number > 0 and number < 1 do
            number = number * 10
            displacement = displacement + 1
        end
        local answer = number
        return answer, displacement
    end

    local function signify(unitVal, sigFigure)
        sigFigure = sigFigure - 1
        while sigFigure ~= 0 do
            unitVal = unitVal * 10
            sigFigure = sigFigure - 1
        end
        return unitVal
    end

    local function divideTen(number, sigFigure)
        while sigFigure ~= 0 do
            number = number / 10
            sigFigure = sigFigure - 1
        end
        local answer = number
        return answer
    end

    local function revert(number, displacement)
        displacement = displacement - 1
        while displacement ~= 0 do
            number = number / 10
            displacement = displacement - 1
        end
        local answer = number
        return answer
    end

    local function computeDec(number, sigFigure)
        local unitVal, displacement = unitDec(number)
        print("UnitVal = " .. unitVal)
        local sigUnit = signify(unitVal, sigFigure)
        print("Rounding off this number " .. sigUnit)
        local roundedSigUnit = round(sigUnit)
        print("Rounded unit is " .. roundedSigUnit)
        local answer = revert(roundedSigUnit, sigFigure)
        print("unit answer = " .. answer)
        answer = divideTen(answer, displacement)
        return answer
    end

    local function unit(number)
        local unit
        local displacement = 1
        while number >= 10 do
            number = number / 10
            displacement = displacement + 1
        end
        unit = number
        return unit, displacement
    end

    local function multiTen(roundedUnit, displacement)
        while displacement ~= 0 do
            roundedUnit = roundedUnit * 10
            displacement = displacement - 1
        end
        local answer = roundedUnit
        return answer
    end

    local function compute(number, sigFigure)
        local unit, displacement = unit(number)
        local sigUnit = signify(unit, sigFigure)
        print("Rounding off this number " .. sigUnit)
        local roundedSigUnit = round(sigUnit)
        print("Rounded unit is " .. roundedSigUnit)
        local diff
        if displacement > sigFigure then
            diff = displacement - sigFigure
            local answer = multiTen(roundedSigUnit, diff)
            return answer
        else
            diff = sigFigure - displacement
            local answer = divideTen(roundedSigUnit, diff)
            return answer
        end
    end

    local function solve()
        local answer
        if number > 0 and number < 1 then
            answer = computeDec(number, sigFigure)
            print("Answer is " .. answer)
        else
            answer = compute(number, sigFigure)
            print("Answer is " .. answer)
        end
        return answer
    end
    local answer = solve()
    return answer
end
local roundedAnswer = roundOff(number, sigFigure)
print("your rounded answer is " .. roundedAnswer .. ", to the nearest " .. sigFigure .. " s.f.")
