// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ArraysExercise {
    // 문제에서 준 starter 코드
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

    // Timestamp Saving용 상태 변수
    address[] public senders;
    uint[] public timestamps;

    uint constant Y2K = 946702800; // 2000-01-01 00:00:00 UTC

    // ---------- 1. 전체 배열 반환 ----------

    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    // ---------- 2. numbers 리셋 (1~10) ----------

    function resetNumbers() public {
        delete numbers; // 기존 값 모두 삭제

        // push를 쓰는 가장 간단한 버전 (문제에서 허용)
        for (uint i = 1; i <= 10; i++) {
            numbers.push(i);
        }
    }

    // ---------- 3. 배열 뒤에 이어붙이기 ----------

    function appendToNumbers(uint[] calldata _toAppend) external {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // ---------- 4. Timestamp 저장 ----------

    function saveTimestamp(uint _unixTimestamp) external {
        // 호출한 사람의 주소와 타임스탬프를 나란히 저장
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // ---------- 5. Y2K 이후만 필터링 ----------

    // 2000-01-01 00:00:00 (946702800) 이후의 timestamp들과
    // 그에 대응하는 sender 주소들을 반환
    function afterY2K() external view returns (uint[] memory, address[] memory) {
        // 1차 루프: 조건을 만족하는 개수 세기
        uint count;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                count++;
            }
        }

        // 2차 루프: 정확한 길이의 memory 배열을 만들고 채우기
        uint[] memory filteredTimestamps = new uint[](count);
        address[] memory filteredSenders = new address[](count);

        uint index;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K) {
                filteredTimestamps[index] = timestamps[i];
                filteredSenders[index] = senders[i];
                index++;
            }
        }

        return (filteredTimestamps, filteredSenders);
    }

    // ---------- 6. Reset 함수들 ----------

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }
}
