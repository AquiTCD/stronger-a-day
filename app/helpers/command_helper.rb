module CommandHelper # rubocop:disable Metrics/ModuleLength
  def styled_topic(inputs = "", game = @game)
    return "" if inputs&.strip.blank?
    return inputs unless current_user.styled_movements

    input_array = inputs.split(/(\{[^\{\})]*\})/).compact_blank
    parsed = input_array.map do |input|
      if input.start_with?("{") && input.end_with?("}")
        parse(input[1..-2], game)
      else
        input
      end
    end
    sanitize_for(parsed.join)
  end

  def styled_movements(inputs = "", game = @game)
    return "" if inputs&.strip.blank?
    return inputs unless current_user.styled_movements

    parsed = parse(inputs, game)
    sanitize_for(parsed)
  end

  private

    def sanitize_for(parsed_input)
      sanitize(
        parsed_input,
        tags: %w[span svg path style g circle],
        attributes: %w[class aria-hidden xmlns fill viewbox version stroke stroke-linecap xml:space style type stroke-linejoin x y stroke-width d cx cy r fill],
      )
    end

    def parse(inputs, game)
      array = inputs.split(/\s*-?[>→＞]\s*/)
      array = array.map do |input|
        input = normalize(input, game)
        input = decorate(input, game)
        "<span class='border border-gray-500 rounded px-1.5 py-0.5 font-normal'>#{input}</span>"
      end
      all = array.join(right_arrow)
      "<span class='leading-loose mr-1'>#{all}</span>"
    end

    def right_arrow
      '<svg class="w-6 h-6 text-white inline-block" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 5 7 7-7 7"/></svg>' # rubocop:disable Layout/LineLength
    end

    def normalize(input, game)
      input = input.tr("０-９ａ-ｚＡ-Ｚ＋", "0-9a-zA-Z+")
      case game.abbreviation
      when "SF6"
        normalize_for_sf6(input)
      when "TEKKEN8"
        normalize_for_tekken8(input)
      else
        input
      end
    end

    def normalize_for_sf6(input)
      input = input.gsub(/p|k|od|di|dr|sa/, &:upcase)
      input = input.gsub(/l(?!v)/i, "弱")
      input = input.gsub("小", "弱")
      input = input.gsub("M", "中")
      input = input.gsub(/h(?!it)/i, "強")
      input = input.gsub(/(?<!最)大(?!砲)/i, "強")
      input = input.gsub("ジャンプ", "J")
      input.gsub("ラッシュ", "DR")
    end

    def normalize_for_tekken8(input)
      input = input.gsub(/(l|r|w)(p|k)/, &:upcase)
      input.gsub(/(w)(l|r)/, &:upcase)
    end

    def decorate(input, game)
      case game.abbreviation
      when "SF6"
        decorate_for_sf6(input)
      when "TEKKEN8"
        decorate_for_tekken8(input)
      else
        input
      end
    end

    def decorate_for_sf6(input)
      words = input.split(/((?<!sa)(?<!lv)(?<![\-ー~～〜x×])\d(?!hit)(?![f\-ー~～〜]))|((?<!s)[PK])|(OD)|(弱)|((?<!空)中)|(強(?!化))/i).compact_blank
      words = words.map do |word|
        case word
        when "1", "2", "3", "4", "6", "7", "8", "9"
          change_arrow(word.to_i)
        when "P", "K"
          "<span class='rounded-full border border-gray-200 w-5 h-5 text-sm font-bold inline-block text-center mx-0.5'>#{word}</span>"
        when "OD", "弱", "中", "強"
          "<span class='font-bold'>#{word}</span>"
        else
          word
        end
      end
      words.join
    end

    def decorate_for_tekken8(input) # rubocop:disable Metrics/MethodLength
      words = input.split(/(\dH?)|(LP\+RK|RK\+LP|RP\+LK|LK\+RP|[LRW][PK]|W[RL])/i).compact_blank
      words = words.map do |word|
        case word
        when /\dH?/
          arrows = word.split(/(\d)(H?)/)
          change_arrow(arrows[1].to_i, hold: arrows[2].present?, bold: true)
        when /LP\+RK|RK\+LP|RP\+LK|LK\+RP|[LRW][PK]|W[RL]/
          fill_lp = (word =~ /.*(LP|WP|WL).*/) ? "fill='white'" : ""
          fill_rp = (word =~ /.*(RP|WP|WR).*/) ? "fill='white'" : ""
          fill_lk = (word =~ /.*(LK|WK|WL).*/) ? "fill='white'" : ""
          fill_rk = (word =~ /.*(RK|WK|WR).*/) ? "fill='white'" : ""
          "<svg xmlns:svg='http://www.w3.org/2000/svg' xmlns='http://www.w3.org/2000/svg' version='1.1' class='w-6 h-6 text-white inline-block'>
            <circle cx='5' cy='7' r='4' stroke='white' stroke-width='1.5' #{fill_lp}></circle>
            <circle cx='15' cy='5' r='4' stroke='white' stroke-width='1.5' #{fill_rp}></circle>
            <circle cx='7' cy='17' r='4' stroke='white' stroke-width='1.5' #{fill_lk}></circle>
            <circle cx='17' cy='15' r='4' stroke='white' stroke-width='1.5' #{fill_rk}></circle>
          </svg>"
        else
          word
        end
      end
      words.join
    end

    def change_arrow(number, hold: false, bold: false) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
      return "☆" if number == 5

      rotation_class =
        case number
        when 1
          "-scale-x-100 scale-y-100 -rotate-45"
        when 2
          "rotate-90"
        when 3
          "rotate-45"
        when 4
          "-scale-x-100 scale-y-100"
        when 6
          ""
        when 7
          "-scale-x-100 scale-y-100 rotate-45"
        when 8
          "-rotate-90"
        when 9
          "-rotate-45"
        end

      if bold
        fill = hold ? "fill='white'" : nil
        "<svg xmlns:svg='http://www.w3.org/2000/svg' xmlns='http://www.w3.org/2000/svg' version='1.1' class='w-6 h-6 text-white inline-block #{rotation_class}'><path #{fill} stroke='white' stroke-width='1.5' stroke-linejoin='round' d='M 21,12 L 12,3 12,8 3,8 3,16 12,16 12,21 21,12 Z'></path></svg>" # rubocop:disable Layout/LineLength
      else
        "<svg version='1.1' class='w-6 h-6 text-white inline-block mx-px #{rotation_class}' id='_x31_0' xmlns='http://www.w3.org/2000/svg' x='0px' y='0px' viewBox='0 0 512 512' style='width: 16px; height: 16px; opacity: 1;' xml:space='preserve' fill='white'><g><path class='st0' d='M486.625,204.945L310.141,71.246c-11.246-8.519-24.598-13.019-38.622-13.019 c-35.347,0-64.102,28.742-64.102,64.07v18.683H64.047C28.73,140.98,0,169.71,0,205.023v101.954 c0,35.312,28.73,64.042,64.047,64.042h143.37v18.684c0,35.328,28.754,64.07,64.102,64.07c14.02,0,27.375-4.5,38.618-13.016 L486.629,307.05C502.516,295.019,512,275.934,512,256S502.516,216.98,486.625,204.945z M455.711,266.238L279.222,399.945 c-2.394,1.813-5.082,2.63-7.703,2.63c-6.656,0-12.902-5.258-12.902-12.871v-57.035c0-7.098-5.75-12.848-12.843-12.848H64.047 c-7.094,0-12.848-5.75-12.848-12.843V205.023c0-7.094,5.754-12.844,12.848-12.844h181.726c7.094,0,12.843-5.75,12.843-12.847 v-57.035c0-7.614,6.246-12.871,12.902-12.871c2.622,0,5.309,0.817,7.703,2.629l176.489,133.707 C462.496,250.898,462.496,261.102,455.711,266.238z' style='fill: rgb(255, 255, 255);'></path></g></svg>" # rubocop:disable Layout/LineLength
      end
    end
end
