// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BasicMath {

    // 덧셈 함수
    // 입력: _a, _b
    // 출력: (합, 에러 여부)
    function adder(uint _a, uint _b) external pure returns (uint sum, bool error) {
        unchecked {
            uint result = _a + _b;

            // 오버플로우 체크: 결과가 원래 값보다 작으면 overflow
            if (result < _a) {
                return (0, true);   // 합: 0, 에러: true
            }

            return (result, false);  // 정상: 합, 에러: false
        }
    }

    // 뺄셈 함수
    // 입력: _a, _b
    // 출력: (차, 에러 여부)
    function subtractor(uint _a, uint _b) external pure returns (uint difference, bool error) {
        unchecked {
            // 언더플로우 체크: _b > _a 이면 음수가 되어 underflow
            if (_b > _a) {
                return (0, true);   // 차: 0, 에러: true
            }

            return (_a - _b, false); // 정상: 차, 에러: false
        }
    }
}
