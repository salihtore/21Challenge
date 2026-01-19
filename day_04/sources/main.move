/// DAY 4: Vector + Ownership Basics
/// 
/// Today you will:
/// 1. Learn about vectors
/// 2. Create a list of habits
/// 3. Understand basic ownership concepts

module challenge::day_04 {

    // Copy the Habit struct from day_03
    public struct Habit has copy, drop {
        name: vector<u8>,
        completed: bool,
    }

    // Constructor function to create new Habit
    public fun new_habit(name: vector<u8>): Habit {
        Habit {
            name,
            completed: false,
        }
    }

    //Create a struct called 'HabitList'
    public struct HabitList has drop {
        habits : vector<Habit>
    }

    //Function that returns an empty HabitList
    public fun empty_list(): HabitList {
        HabitList {
            habits : vector::empty<Habit>()
        }
    }
    //Function that adds a habit to the list
    public fun add_habit(list: &mut HabitList, habit: Habit) {
        vector::push_back(&mut list.habits, habit);
    }

}

