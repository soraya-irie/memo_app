require 'csv'

# 新しいメモを追加するための関数
def add_memo(file_name, memo) 
  CSV.open(file_name, "a") do |csv| # "a"は追記モード
    csv << [memo]
  end
  puts "メモを追加しました。"
end

# 編集するための関数
def edit_memo(file_name)
  memos = CSV.read(file_name)
  puts "編集するメモの行の番号を選択してください:"
  memos.each_with_index do |memo, index|
    puts "#{index + 1}: #{memo.join}"
  end

  which_line = gets.chomp.to_i

  if which_line < 1 || which_line > memos.length
    puts "無効な選択です。"
    return
  end

  puts "新しいメモの内容を入力してください:"
  new_memo = gets.chomp
  memos[which_line - 1] = [new_memo]

  CSV.open(file_name, "w") do |csv| # "w"はファイルの内容を上書き
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
      puts "作成するファイル名を入力してください（拡張子.csvを含まない）:"
      name = gets.chomp
      file_name = "#{name}.csv"
     
      puts "メモに追加するテキストを入力してください:"
      memo = gets.chomp
      add_memo(file_name, memo)
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

