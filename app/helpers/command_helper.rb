module CommandHelper
  def styled_movements(inputs = "")
    parsed = parse(inputs)
    sanitize(
      parsed,
      tags: %w[span svg path style g],
      attributes: %w[class aria-hidden xmlns fill viewbox version stroke stroke-linecap xml:space style type stroke-linejoin x y stroke-width d],
    )
  end

  private

    def parse(inputs)
      array = inputs.split(/\s*[>→＞]\s*/)
      array = array.map do |input|
        input = normalize(input)
        input = decorate(input)
        "<span class='border border-gray-500 rounded px-1.5 py-0.5 font-normal'>#{input}</span>"
      end
      all = array.join(right_arrow)
      "<span class='leading-loose'>#{all}</span>"
    end

    def right_arrow
      '<svg class="w-6 h-6 text-white inline-block" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 5 7 7-7 7"/></svg>' # rubocop:disable Layout/LineLength
    end

    def normalize(input)
      input = input.tr("０-９ａ-ｚＡ-Ｚ", "0-9a-zA-Z")
      input = input.gsub(/[pP]/, "P")
      input = input.gsub(/[kK]/, "K")
      input = input.gsub("od", "OD")
      input = input.gsub("L", "弱")
      input = input.gsub("M", "中")
      input = input.gsub("H", "強")
      input = input.gsub("ジャンプ", "J")
      input = input.gsub("ラッシュ", "DR")
      input.gsub("キャンセル", "[c]")
    end

    def decorate(input)
      words = input.split(/((?<!SA)\d)|([PK])|(OD|弱|中|強)/).compact_blank
      words = words.map do |word|
        case word
        when /(?<!SA)\d/
          change_arrow(word.to_i)
        when /[PK]/
          "<span class='rounded-full border border-gray-200 w-5 h-5 text-sm font-bold inline-block text-center mx-0.5'>#{word}</span>"
        when /(OD|弱|中|強)/
          "<span class='font-bold'>#{word}</span>"
        else
          word
        end
      end
      words.join
    end

    def change_arrow(number) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
      return number if number == 0
      return "立" if number == 5

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
      "<svg version='1.1' class='w-6 h-6 text-white inline-block mr-0.5 #{rotation_class}' id='_x31_0' xmlns='http://www.w3.org/2000/svg' x='0px' y='0px' viewBox='0 0 512 512' style='width: 16px; height: 16px; opacity: 1;' xml:space='preserve'><g><path class='st0' d='M486.625,204.945L310.141,71.246c-11.246-8.519-24.598-13.019-38.622-13.019 c-35.347,0-64.102,28.742-64.102,64.07v18.683H64.047C28.73,140.98,0,169.71,0,205.023v101.954 c0,35.312,28.73,64.042,64.047,64.042h143.37v18.684c0,35.328,28.754,64.07,64.102,64.07c14.02,0,27.375-4.5,38.618-13.016 L486.629,307.05C502.516,295.019,512,275.934,512,256S502.516,216.98,486.625,204.945z M455.711,266.238L279.222,399.945 c-2.394,1.813-5.082,2.63-7.703,2.63c-6.656,0-12.902-5.258-12.902-12.871v-57.035c0-7.098-5.75-12.848-12.843-12.848H64.047 c-7.094,0-12.848-5.75-12.848-12.843V205.023c0-7.094,5.754-12.844,12.848-12.844h181.726c7.094,0,12.843-5.75,12.843-12.847 v-57.035c0-7.614,6.246-12.871,12.902-12.871c2.622,0,5.309,0.817,7.703,2.629l176.489,133.707 C462.496,250.898,462.496,261.102,455.711,266.238z' style='fill: rgb(255, 255, 255);'></path></g></svg>" # rubocop:disable Layout/LineLength
    end
end
