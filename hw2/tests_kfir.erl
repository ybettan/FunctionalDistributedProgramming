-module(tests_kfir).
-export([test_1/0, test_2/0, test_3/0, test_4/0, test_5/0, test_parallel_mult/0]).

test_1()->
    % Compile files
    


    io:format("[*] Starting server ~n"),
    matrix_server:start_server(),
    io:get_line("Press enter to continue"),

    io:format("[*] Check server version & upgrade ~n"),
    Ver1 = matrix_server:get_version(),
    version_1 = Ver1,

    io:format("[*] Please update your code now for version_2, and compile & load it. After that run test2 ~n").

test_2()->
    matrix_server ! sw_upgrade,
    Ver2 = matrix_server:get_version(),
    version_2 = Ver2,

    io:format("[*] Please update your code now for version_3, and compile & load it. After that run test3 ~n").

test_3()->
    matrix_server ! sw_upgrade,
    Ver3 = matrix_server:get_version(),
    version_3 = Ver3,

    io:format("[*] Please update your code now for version_1, and compile & load it. After that run test4 ~n").

test_4()->
    matrix_server ! sw_upgrade,
    Ver1 = matrix_server:get_version(),
    version_1 = Ver1,

    io:format("[*] Upgraded successfully ~n"),


    io:format("[*] Checking mult ~n"),
    Mat1 = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}},
    Mat2 = {{1, 2, 3}, {1, 2, 3}, {4, 5, 6}},
    Mat3 = {{4, 5, 6}, {1, 2, 3}, {4, 5, 6}},

    Mat4 = {{1}},
    Mat5 = {{9}},

    Mat6 = {{1, 2, 3}, {3, 4, 5}},
    Mat7 = {{9, 1}, {3, 4}, {2, -5}},

    io:format("[*] mult1 ~n"),
    Mat1 = matrix_server:mult(Mat1, Mat1),
    io:format("[*] mult2 ~n"),
    Mat2 = matrix_server:mult(Mat1, Mat2),
    io:format("[*] mult3 ~n"),
    Mat3 = matrix_server:mult(Mat1, Mat3),

    io:format("[*] mult4 ~n"),
    {{15, 21, 27}, {15, 21, 27}, {33, 48, 63}} = matrix_server:mult(Mat2, Mat2),
    io:format("[*] mult5 ~n"),
    {{18, 24, 30}, {18, 24, 30}, {45, 60, 75}} = matrix_server:mult(Mat2, Mat3),
    io:format("[*] mult6 ~n"),
    {{45, 60, 75}, {18, 24, 30}, {45, 60, 75}} = matrix_server:mult(Mat3, Mat3),
    io:format("[*] mult7 ~n"),
    {{33, 48, 63}, {15, 21, 27}, {33, 48, 63}} = matrix_server:mult(Mat3, Mat2),
    io:format("[*] mult8 ~n"),
    {{9}} = matrix_server:mult(Mat4, Mat5),
    io:format("[*] mult9 ~n"),
    {{9}} = matrix_server:mult(Mat5, Mat4),
    io:format("[*] mult10 ~n"),
    {{21, -6}, {49, -6}} = matrix_server:mult(Mat6, Mat7),


    io:format("[*] check mult in parallel ~n"),
    spawn(?MODULE, test_parallel_mult, []),
    spawn(?MODULE, test_parallel_mult, []),
    spawn(?MODULE, test_parallel_mult, []),
    spawn(?MODULE, test_parallel_mult, []),
    spawn(?MODULE, test_parallel_mult, []),
    spawn(?MODULE, test_parallel_mult, []),                


    io:format("[*] finished mults ~n").

test_parallel_mult()->

    io:format("[*] Checking mult ~n"),
    Mat1 = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}},
    Mat2 = {{1, 2, 3}, {1, 2, 3}, {4, 5, 6}},
    Mat3 = {{4, 5, 6}, {1, 2, 3}, {4, 5, 6}},
    Mat4 = {{1}},
    Mat5 = {{9}},
    Mat6 = {{1, 2, 3}, {3, 4, 5}},
    Mat7 = {{9, 1}, {3, 4}, {2, -5}},
    Mat1 = matrix_server:mult(Mat1, Mat1),
    Mat2 = matrix_server:mult(Mat1, Mat2),
    Mat3 = matrix_server:mult(Mat1, Mat3),
    {{15, 21, 27}, {15, 21, 27}, {33, 48, 63}} = matrix_server:mult(Mat2, Mat2),
    {{18, 24, 30}, {18, 24, 30}, {45, 60, 75}} = matrix_server:mult(Mat2, Mat3),
    {{45, 60, 75}, {18, 24, 30}, {45, 60, 75}} = matrix_server:mult(Mat3, Mat3),
    {{33, 48, 63}, {15, 21, 27}, {33, 48, 63}} = matrix_server:mult(Mat3, Mat2),
    {{9}} = matrix_server:mult(Mat4, Mat5),
    {{9}} = matrix_server:mult(Mat5, Mat4),
    {{21, -6}, {49, -6}} = matrix_server:mult(Mat6, Mat7),
    io:format("[*] finished mults ~n").

test_5()->
    io:format("[*] Explanation ~n"),
    io:format("~p ~n", [matrix_server:explanation()]),
    io:format("[*] Shutdown ~n"),
    matrix_server ! shutdown.



