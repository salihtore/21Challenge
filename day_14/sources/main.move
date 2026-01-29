/// DAY 14: Tests for Bounty Board
///
/// Today you will:
/// 1. Write comprehensive tests
/// 2. Test all the functions you've created
/// 3. Practice test organization
///
/// Note: You can copy code from day_13/sources/solution.move if needed

module challenge::day_14;

use std::option::{Self, Option};
use std::string::{Self, String};
use std::vector;

#[test_only]
use std::unit_test::assert_eq;

// Copy from day_13: All structs and functions
public enum TaskStatus has copy, drop {
    Open,
    Completed,
}

public struct Task has copy, drop {
    title: String,
    reward: u64,
    status: TaskStatus,
}

public struct TaskBoard has drop {
    owner: address,
    tasks: vector<Task>,
}

public fun new_task(title: String, reward: u64): Task {
    Task {
        title,
        reward,
        status: TaskStatus::Open,
    }
}

public fun new_board(owner: address): TaskBoard {
    TaskBoard {
        owner,
        tasks: vector::empty(),
    }
}

public fun add_task(board: &mut TaskBoard, task: Task) {
    vector::push_back(&mut board.tasks, task);
}

public fun complete_task(task: &mut Task) {
    task.status = TaskStatus::Completed;
}

public fun total_reward(board: &TaskBoard): u64 {
    let len = vector::length(&board.tasks);
    let mut total = 0;
    let mut i = 0;
    while (i < len) {
        let task = vector::borrow(&board.tasks, i);
        total = total + task.reward;
        i = i + 1;
    };
    total
}

public fun completed_count(board: &TaskBoard): u64 {
    let len = vector::length(&board.tasks);
    let mut count = 0;
    let mut i = 0;
    while (i < len) {
        let task = vector::borrow(&board.tasks, i);
        if (task.status == TaskStatus::Completed) {
            count = count + 1;
        };
        i = i + 1;
    };
    count
}

// TODO: Write at least 3 tests:

#[test]
fun test_create_board_and_add_task() {
    // - Create a board with an owner
    let owner: address = @0x1;

    let mut board: TaskBoard = new_board(owner);
    let task = new_task(string::utf8(b"Fix bug"), 100);

    // - Add a task
    add_task(&mut board, task);

    // - Verify the task was added
    let len: u64 = vector::length(&board.tasks);
    assert_eq!(len, 1);
}

//
// Test 2: test_complete_task

#[test]
fun test_complete_task() {
    let owner: address = @0x1;

    // - Create board, add tasks
    let mut board: TaskBoard = new_board(owner);
    let task1 = new_task(string::utf8(b"Task 1"), 50);
    add_task(&mut board, task1);

    // Complete first task
    let task = vector::borrow_mut(&mut board.tasks, 0);
    complete_task(task);

    assert_eq!(completed_count(&board), 1);
}

#[test]
fun test_total_reawrd(){
    let owner: address = @0x1;
    let mut board = new_board(owner);
    let task1 = new_task(string::utf8(b"Task 1"), 50);

    add_task(&mut board, task1);

    let total = total_reward(&board);
    assert_eq!(total, 175);
}
