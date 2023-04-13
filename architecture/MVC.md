## MVC

- architectural pattern made of up 3 main objects:
### Model (handles how data is stored)
- A model object groups the data you need to represent items or concepts
- Model objects are made up of properties that represent attributes of the type, and they sometimes have methods for updating and modifying their own properties.

E.g. task in a to-do list, the names of products in a store

### View (represents UI)
- presenting data to the user and handling user interaction.
- When users interacts with your app, they are interacting with the view layer. It should not contain any business logic.
- Includes UIView subclasses, Classes that part of UIKit, Core Animation, Core Graphics
- Make sure it doesn't interact with the model layer, contain any business logic and UI

E.g. a table showing the list of products available

### Controller (mediator between model and view)
- altering the Model by reacting to the user’s actions performed on the View and updating the View with changes from the Model.
For example, when the user interacts with a view, the view sends a message to a view controller, and the view controller can then update the model object.

- ** VIEW and MODEL NEVER interact with each other **

E.g. querying the model and converting its data to something views can show.

2 types of controllers: model and helper controllers

Model controllers: 

- Multiple objects or scenes need access to the model data.
- The logic for adding, modifying, or deleting model data is complex.
- You want to keep the code in your view controllers focused on managing the views.

Helper controllers:
- are useful anytime you want to consolidate related data or functionality so that it can be accessed by other objects in your app. 
- E.g. NetworkController, which manages all the network requests in a given app.

### Example 
E.g. Imagine you're tasked with building an app to track photos of meals that the user has eaten, along with notes and an optional rating of each meal.

#### Model

if the app is going to track meals, it makes sense to have a model object called `Meal` that holds the data about each meal.

```
struct Meal { 
    var name: String
    var photo: UIImage
    var notes: String
    var rating: Int
    int timestamp: Date
}
```

#### View

2 scenes: one will display a list of all the meals and another will display the details of a meal

The meal list scene could display the list in a table view, with the name and photo of each meal in an individual cell. The meal detail scene could then display the name of the meal in a nav bar, a photo in an image view, notes abotu the meal in a text view and current rating in a segmented control.

#### Controller

Meal List Table View Controller

- should have a property that holds a collection of meals to display
- should response to any user events

```
class MealListTableViewController: UITableViewController {
 
    var meals: [Meal] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the meals and set up the table view
    }
 
    // Required table view methods
 
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {...}
 
    override func tableView(_ tableView: UITableView,
       cellForRowAt indexPath: IndexPath) -> UITableViewCell {...}
 
    // Navigation methods
 
    @IBSegueAction func showMealDetails(_ coder: NSCoder) ->
       MealDetailViewController?
        // Initialize MealDetailViewController with selected Meal
           and return
    }
 
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        // Capture the new or updated meal from the
           MealDetailViewController and save it to the meals
           property
    }
 
    // Persistence methods
 
    func saveMeals() {
        // Save the meals model data to the disk
    }
 
    func loadMeals() {
        // Load meals data from the disk and assign it to the
           meals property
    }
}
```

MealDetailViewController 

```
class MealDetailViewController: UIViewController, UIImagePickerControllerDelegate {
 
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var saveButton: UIBarButtonItem!
     
    var meal: Meal
     
    init?(coder: NSCoder, meal: Meal) {
        self.meal = meal
        super.init(coder: coder)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update view components using the Meal model
    }
     
    // Navigation methods
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Update the meal property that will be accessed by the
        MealListTableViewController to update the list of meals
    }
     
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Dismiss the view without saving the meal
    }
```

References: 

1. Develop in Swift Data Collections
