# encoding: utf-8
require "csv"

# ===== メソッドの定義 =====
def get_last_line_number
  if File.exist?("memo.csv")
    File.open("memo.csv").read.count("\n")
  else
    0
  end
end

def show
  CSV.foreach("memo.csv") do |row|
    puts "#{row.first}: #{row.last}"
  end
  puts # 改行
end



# csvファイルへの書き込み
def write(contents, mode)
  CSV.open('memo.csv', mode) do |file|
    # contents: Hash = {key => value}
    contents.each do |index, content|
      file << [index, content]
    end
  end
end

def create
  puts "新規メモを入力してください。"

  content = gets.to_s.chomp
  index = get_last_line_number + 1

  contents = {index.to_s => content}
  write(contents, 'a')

  puts "メモを作成しました！"
end

def update
  puts "編集したいメモの番号を入力してください"
  show

  index = gets.to_i

  if (index == 0) || (get_last_line_number < index)
    puts "入力された値が不正です。"
  else
    puts "更新する内容を入力してください"
    puts

    content = gets.to_s.chomp
    # {"1"=>"test1", "2"=>"test2", "3"=>"test3", "4"=>"test4"}
    contents = CSV.read('memo.csv').to_h
    contents[index.to_s] = content

    write(contents, 'w')

    puts "メモを更新しました！"
  end
end
# ===== //メソッドの定義 =====

# 最初に実行される
if get_last_line_number == 0
  create
else
  puts "1(新規でメモを作成) 2(既存のメモ編集する)"
  puts # 改行

  # ユーザーからの入力を待ち受ける
  memo_type = gets.to_i

  if memo_type == 1
    create
  elsif memo_type == 2
    update
  else
    puts 'アプリケーションを終了しました。'
  end
end