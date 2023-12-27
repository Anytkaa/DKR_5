
type
  TComparator = function(a, b: Integer): Integer;

procedure BubbleSort(arr: array of Integer; cmp: TComparator);
var
  i, j, temp: Integer;
begin
  for i := Length(arr) - 1 downto 1 do
  begin
    for j := 0 to i - 1 do
    begin
      if cmp(arr[j], arr[j + 1]) > 0 then
      begin
        temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
      end;
    end;
  end;
end;

function AscendingComparator(a, b: Integer): Integer;
begin
  Result := a - b;
end;

function DescendingComparator(a, b: Integer): Integer;
begin
  Result := b - a;
end;

var
  inputData: array of Integer;
  cmp: TComparator;
  i: Integer;
  inputFile: TextFile;
  inputFileName: string;

begin
  // Введите имя файла со входными данными
  Write('Введите имя файла со входными данными: ');
  ReadLn(inputFileName);
  
  // Открываем файл для чтения
  AssignFile(inputFile, inputFileName);
  Reset(inputFile);
  
  // Считываем данные из файла и сохраняем их в массиве
  while not EOF(inputFile) do
  begin
    SetLength(inputData, Length(inputData) + 1);
    ReadLn(inputFile, inputData[Length(inputData) - 1]);
  end;
  
  // Закрываем файл
  CloseFile(inputFile);
  
  // Выводим исходные данные
  WriteLn('Исходные данные:');
  for i := 0 to Length(inputData) - 1 do
    WriteLn(inputData[i]);
  
  // Сортируем данные по возрастанию
  cmp := AscendingComparator;
  BubbleSort(inputData, cmp);
  
  // Выводим отсортированные данные
  WriteLn('Отсортированные данные (по возрастанию):');
  for i := 0 to Length(inputData) - 1 do
    WriteLn(inputData[i]);
  
  // Сортируем данные по убыванию
  cmp := DescendingComparator;
  BubbleSort(inputData, cmp);
  
  // Выводим отсортированные данные
  WriteLn('Отсортированные данные (по убыванию):');
  for i := 0 to Length(inputData) - 1 do
    WriteLn(inputData[i]);
  
  ReadLn;
end.