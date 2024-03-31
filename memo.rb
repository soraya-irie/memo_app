require 'csv'

# 新しいメモを追加するための関数
def add_memo(file_name)
  puts "メモに追加するテキストを入力してください (終了するには'end'と入力):"
  
  memo_lines = []
  loop do #復習行入力するためのループ
    line = gets.chomp
    break if line == "end"
    memo_lines << line
  end

  memo = memo_lines.join("\n")

  CSV.open(file_name, "a") do |csv|
    csv << [memo]
  end
  
  puts "メモを追加しました。"
end




# 編集するための関数
def edit_memo(file_name)
  memos = CSV.read(file_name)
  puts "編集するメモの番号を選択してください:"
  memos.each_with_index do |memo, index|
    puts "#{index + 1}: #{memo.join}"
  end

  which_line = gets.chomp.to_i
  if which_line < 1 || which_line > memos.length
    puts "無効な選択です。"
    return
  end

  puts "新しいメモの内容を入力してください (終了するには'end'と入力):"
  new_memo_lines = []
  loop do #復習行入力するためのループ
    line = gets.chomp
    break if line == "end"
    new_memo_lines << line
  end
  new_memo = new_memo_lines.join("\n")

  memos[which_line - 1] = [new_memo]

  CSV.open(file_name, "w") do |csv|
    memos.each { |memo| csv << memo }
  end

  puts "メモを更新しました。"
end
 
# メインの機能
def main_loop
  
    puts "メモアプリです。"
    puts "1: メモを追加, 2: メモを編集"

    choice = gets.chomp

    case choice
    when "1"
      puts "追加するファイル名を入力してください（拡張子.csvを含まない）:"
      name = gets.chomp
      file_name = "#{name}.csv"
      add_memo(file_name)
    when "2"
      puts "編集するファイル名を入力してください（拡張子.csvを含まない）:"
      name = gets.chomp
      file_name = "#{name}.csv"
      if File.exist?(file_name)
        edit_memo(file_name)
      else
        puts "#{file_name} は存在しません。"
      end
    else
      puts "1か2を入力してください。"
    end
  
end

main_loop

