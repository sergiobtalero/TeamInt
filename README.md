# TeamInt

## Architecture
The app was clean-oriented built, thus you will find following frameworks:

**Data**: Contains the services, entities and implements providers.

**Domain**: Contains business logic contained on Use Cases, as well models which will be used on presentation layer and defines providers contracts.

**Injector**: Framework created for injecting to presentation layer with required data from both Data and Domain.

**Presentation**: Called *homework*, implemented using MVP.

## Used Frameworks:
Besides the original frameworks included on the provided project, PromiseKit was added to the project.

PromiseKit helps simplifyng asyncronous calls in a more readable code, which for the case of the app was helpful in order to avoid nesting API calls.

## Testing
All three modules were tested (Data, Domain and Presentation/homework): services, providers, parsers and presenters.

## Comments and pending work
- During the development of the test, the login service kept failing so mocks oof the expected service response had to be implemented on the app, as well as modifying the code in order to don't throw error but to use the mocks created.

- Map should be implemented along with both AC of such module.

## Tips
If having trouble builiding the app, try building targets in following order:
1. Domain
2. Data
3. homework
