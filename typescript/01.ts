{
    // 높은 숫자가 큰 자리에 있을수록 값이 커지므로 내림차순으로 입력받는다.
    const arr: number[] = [9, 7, 5, 3, 1];
    // 어느 인덱스가 선택되었는지 저장한다.
    let selected: number[] = [0, 0, 0, 0, 0];
    // 몇개를 뽑는지를 나타낸다.
    let goal: number = 0;

    let maxValue: number = 0;
    let maxFirst: number = 0;
    let maxSecond: number = 0; 

    // 재귀를 써서 goal만큼 조합으로 뽑는다.
    function selectNumber(now: number, count: number): void {
        if(count == goal) {
            calculateAnswer();
            return;
        }

        for (let i = now; i < arr.length; i++) {
            selected[i] = 1;
            selectNumber(i+1, count+1)
            selected[i] = 0;
        }
        return;
    }

    // selected[i]가 1인 경우와 0인 경우를 모아 두 수를 만들고,
    // 두 수를 곱하여 최댓값을 구한다.
    function calculateAnswer() :void{
        let firstCount :number = 1
        let secondCount :number = 1
        let firstNumber :number = 0
        let secondNumber :number = 0
        for (let i = 4; i > -1; i--) {
            if (selected[i] == 0) {
                firstNumber += firstCount*arr[i];
                firstCount *= 10;
            } else {
                secondNumber += secondCount*arr[i];
                secondCount *= 10;
            }
        }
        if (maxValue < firstNumber*secondNumber) {
            maxValue = firstNumber*secondNumber;
            maxFirst = firstNumber;
            maxSecond = secondNumber;
        }
    }

    // 1개부터 4개까지 선택한다.
    for (let i = 1; i < arr.length; i++) {
        goal = i;
        selectNumber(0, 0);
    }

    console.log("result: ", maxFirst, maxSecond);
}

