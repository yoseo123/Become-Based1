// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ControlStructures {
    // ---------- Smart Contract FizzBuzz ----------

    // fizzBuzz(_number)
    // - 3으로 나누어 떨어지면 "Fizz"
    // - 5로 나누어 떨어지면 "Buzz"
    // - 3과 5 모두로 나누어 떨어지면 "FizzBuzz"
    // - 그 외에는 "Splat"
    function fizzBuzz(uint _number) external pure returns (string memory) {
        if (_number % 15 == 0) {
            return "FizzBuzz";
        }
        if (_number % 3 == 0) {
            return "Fizz";
        }
        if (_number % 5 == 0) {
            return "Buzz";
        }

        return "Splat";
    }

    // ---------- Do Not Disturb ----------

    // 커스텀 에러 정의
    error AfterHours(uint256 time);

    // doNotDisturb(_time)
    // - _time >= 2400 : panic 발생 (assert 사용)
    // - _time > 2200 또는 _time < 800 : AfterHours 에러로 revert
    // - 1200 ~ 1259 : "At lunch!" 문자열로 revert
    // - 800 ~ 1199 : "Morning!"
    // - 1300 ~ 1799 : "Afternoon!"
    // - 1800 ~ 2200 : "Evening!"
    function doNotDisturb(uint _time) external pure returns (string memory) {
        // 1) 2400 이상이면 panic (assert 실패)
        if (_time >= 2400) {
            assert(false); // panic 코드 발생
        }

        // 2) 2200 초과 또는 800 미만이면 영업시간 외
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // 3) 점심시간 1200 ~ 1259
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // 4) 800 ~ 1199: Morning
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        }

        // 5) 1300 ~ 1799: Afternoon
        if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        }

        // 6) 1800 ~ 2200: Evening
        if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // 이 리턴은 이론상 도달하지 않지만,
        // 컴파일러가 모든 경로에 return을 요구하므로 넣어둠.
        return "";
    }
}
