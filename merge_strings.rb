#!/usr/bin/env ruby

# extract_comments("/* abc */ /* 123 */")
# => ["abc", "123"]
def extract_comments(str)
  (str || "").scan(%r"/\*\s*(.*?)\s*\*/").flatten
end

# key_value_line("foo", "bar", ["abc", "123"])
# => '"foo" = "bar"; /* abc */ /* 123 */'
def key_value_line(key, value, comments)
  line = "\"#{key}\" = \"#{value}\";"
  unless comments.empty?
    line = ([line] + comments.map{|c|"/* #{c} */"}).join(" ")
  end
  line
end

if $0 == __FILE__
  if ARGV.count < 2
    puts <<-USAGE
Usage: merge_strings BASE.strings OTHER.strings [default:"TRANSLATION REQUIRED"]

See https://github.com/hiroshi/merge_strings for more information.
    USAGE
    exit 2
  end
  base_strings_path = ARGV[0]
  other_strings_path = ARGV[1]
  translation_required = ARGV[2] || "TRANSLATION REQUIRED"
  # Extract values of other strings
  other_strings = {} #=> {"key": {val: "...", comments: ["...", "..."]}, ...}
  File.read(other_strings_path).each_line do |line|
    if match = line.match(/"([^"]*)"\s*=\s*"([^"]*)"\s*;(.*)$/)
      key, val, comments = $1, $2, extract_comments($3)
      # puts "#{key} = #{val}"
      other_strings[key] = {val: val, comments: comments}
    end
  end
  # Copy base strings file then replace values with other_strings
  File.open(other_strings_path, "w+") do |other_strings_file|
    File.read(base_strings_path).each_line do |line|
      line.sub!(/"([^"]*)"\s*=\s*"([^"]*)"\s*;(.*)$/) do |m|
        key, val, comments = $1, $2, extract_comments($3)
        #puts "#{key} : #{comments}"
        if other = other_strings[key]
          key_value_line(key, other[:val], comments | other[:comments])
        else
          key_value_line(key, key, comments | [translation_required])
        end
      end
      other_strings_file.puts line
    end
  end
end
