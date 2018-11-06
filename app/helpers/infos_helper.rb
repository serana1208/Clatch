module InfosHelper
    def GetRemainDays(kigen)
        sa = (kigen - Date.today ).to_i 
        if sa < 0
            sa = ""
        end
        sa
    end

    def IsLimitNear(kigen, value)
        sa = (kigen - Date.today).to_i
        sa > -1 && sa < value
    end

    def Isnew(create, value)
        day = (Date.today - created_at).to_i
        day < 4 && day < true
    end    
end
