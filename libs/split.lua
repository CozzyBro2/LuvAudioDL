return function(Query, Pattern)
    Pattern = Pattern or '([^\n]+)'

    local Split = {}

    for Str in Query:gmatch(Pattern) do
        table.insert(Split, Str)
    end

    return Split
end