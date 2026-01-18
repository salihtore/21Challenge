/// DAY 3: Structs (Habit Model Skeleton)
/// 
/// Today you will:
/// 1. Learn about structs
/// 2. Create a Habit struct
/// 3. Write a constructor function

module challenge::day_03 {
    use std::vector::Self;
    //create Habit struct
    public struct Habit has copy, drop {
        // name field of type vector<u8>    
        name: vector<u8>,
        // completed field of type bool
        completed: bool,
    }

    //constructor function to create new Habit
    public fun new_habit(name: vector<u8>): Habit {
        Habit {
            name,
            completed: false,
        }
    }   
    #[test] 
    fun test_new_habit(){
        let mut empty_name = vector::empty<u8>();
        vector::push_back(&mut empty_name, 8);
        let mut new_habit = new_habit(empty_name);
        assert!(new_habit.name[0] == 8, 1);
        
    }
}

   