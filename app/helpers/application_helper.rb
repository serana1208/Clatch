module ApplicationHelper
    def GetDateImageFilename(date,type)
      if type == 1
        item = date.month
      elsif type == 2
        item = date.day
      end

      case type
        when 1          # 月の場合
            ret = asset_path 'public/' + item.to_s + '.png'
        when 2          # 日の場合
            ret = asset_path 'public/' + item.to_s + '.png'
        when 3          # 曜日の場合
            wd = date.wday
         case wd
           when 0
             ret = asset_path 'public/日曜日.png'    
           when 1
             ret = asset_path 'public/月曜日.png'
           when 2
             ret = asset_path 'public/火曜日.png'
           when 3
             ret = asset_path 'public/水曜日.png'
           when 4
             ret = asset_path 'public/木曜日.png'
           when 5
             ret = asset_path 'public/金曜日.png'
           when 6
             ret = asset_path 'public/土曜日.png'
          end
      end

      ret
    end
end
