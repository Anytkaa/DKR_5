
type
  TComparator = function(a, b: Integer): Integer;

procedure Merge(arr: array of Integer; left, mid, right: Integer; cmp: TComparator);
var
  i, j, k: Integer;
  n1, n2: Integer;
  L, R: array of Integer;
begin
  n1 := mid - left + 1;
  n2 := right - mid;
  
  SetLength(L, n1);
  SetLength(R, n2);
  
  for i := 0 to n1 - 1 do
    L[i] := arr[left + i];
    
  for j := 0 to n2 - 1 do
    R[j] := arr[mid + 1 + j];
    
  i := 0;
  j := 0;
  k := left;
  
  while (i < n1) and (j < n2) do
  begin
    if cmp(L[i], R[j]) <= 0 then
    begin
      arr[k] := L[i];
      Inc(i);
    end
    else
    begin
      arr[k] := R[j];
      Inc(j);
    end;
    Inc(k);
  end;
  
  while i < n1 do
  begin
    arr[k] := L[i];
    Inc(i);
    Inc(k);
  end;
  
  while j < n2 do
  begin
    arr[k] := R[j];
    Inc(j);
    Inc(k);
  end;
end;

procedure MergeSort(arr: array of Integer; left, right: Integer; cmp: TComparator);
var
  mid: Integer;
begin
  if left < right then
  begin
    mid := (left + right) div 2;
    MergeSort(arr, left, mid, cmp);
    MergeSort(arr, mid + 1, right, cmp);
    Merge(arr, left, mid, right, cmp);
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
  MergeSort(inputData, 0, Length(inputData) - 1, cmp);
  
  // Выводим отсортированные данные
  WriteLn('Отсортированные данные (по возрастанию):');
  for i := 0 to Length(inputData) - 1 do
    WriteLn(inputData[i]);
  
  // Сортируем данные по убыванию
  cmp := DescendingComparator;
  MergeSort(inputData, 0, Length(inputData) - 1, cmp);
  
  // Выводим отсортированные данные
  WriteLn('Отсортированные данные (по убыванию):');
  for i := 0 to Length(inputData) - 1 do
    WriteLn(inputData[i]);
  
  ReadLn;
end.
