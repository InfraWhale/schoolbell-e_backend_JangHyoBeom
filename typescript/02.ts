{
    // 1을 land, 0을 sea로 한다.
    const arr: number[][] = 
    [
        [1, 0, 1, 0, 0], 
        [1, 0, 0, 0, 0], 
        [1, 0, 1, 0, 1], 
        [1, 0, 0, 1, 0]
    ];
    
    const n: number = arr.length;
    const m: number = arr[0].length;

    // 방문한 배열을 저장하는 배열
    let visited: number[][] = new Array(n).fill(null).map(() => new Array(m).fill(0));

    // 방향벡터 배열
    const dy: number[] = [-1, 0, 1, 0];
    const dx: number[] = [0, 1, 0, -1];

    // 반환할 정답
    let result: number = 0;

    // 깊이우선탐색 함수
    function dfs(y: number ,x: number): void {
        for (let i = 0; i < 4; i++) {
            let ny: number = y + dy[i];
            let nx: number = x + dx[i];
            if (ny < 0 || ny >= n || nx < 0 || nx >= m || visited[ny][nx] == 1 || arr[ny][nx] == 0) {
                continue;
            } 
            visited[ny][nx] = 1;
            dfs(ny, nx);
        }
        return;
    }

    // 탐색하지 않은 land를 찾아 깊이우선 탐색을 하고 Island의 갯수를 찾는다.
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if(visited[i][j] == 1 || arr[i][j] == 0) {
                continue;
            }
            visited[i][j] = 1;
            dfs(i, j);
            result += 1;
        }
    }

    console.log("result: ", result);
}

