# Usercentrics App Challenge

## How to run
  1) Install cocoapods `pod install` and then open `Usercentrics_Challenge.xcworkspace`
  2) Press Run

## Running UI Tests
  1) If the test fails when running the method `app.uninstall()`, first check if you're using english language on your test device second try to delete manually any app that was previously installed before running the test.
 
## Developer notes or issues found while developing
  1) Swift package manager instalation outputs a checksum error and the sdk installation can't be completed.
  <img width="1075" alt="Screenshot 2022-05-05 at 16 13 07" src="https://user-images.githubusercontent.com/6344775/167125101-39cb4add-4415-4faa-92e0-0fe423269240.png">

  <img width="890" alt="Screenshot 2022-05-06 at 11 04 56" src="https://user-images.githubusercontent.com/6344775/167125086-574081ab-a8be-4ced-9af1-29a1f103c88f.png">
  
  2) First step on initialisation is not completely clear if the settings id should be set at `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool` or anywhere else.
<img width="989" alt="Screenshot 2022-05-06 at 14 47 33" src="https://user-images.githubusercontent.com/6344775/167125621-9849545d-4595-4b9a-aa47-f1cfad5e3f58.png">

  3) Documentation to show first layer refers to settings parameter that doesn't exist on the actual sdk. 
  ```
  **Documentation**
  let banner = UsercentricsBanner()
  banner.showFirstLayer(hostView: self, // Host UIViewController 
                      layout: <UsercentricsLayout>, //.full, .sheet, .popup
                      settings: <FirstLayerStyleSettings?>) { userResponse in
    // Handle userResponse
  }

  **SDK**
  public func showFirstLayer(hostView: UIViewController, layout: UsercentricsUI.UsercentricsLayout, completionHandler: @escaping (UsercentricsUI.UsercentricsConsentUserResponse) -> Void)
```

 4) No option to clean up the consent without having to delete the whole app. Using `UsercentricsCore.reset()` didn't work.
 5) When clicking on links(eg: Privacy policy, Imprint) if the url is invalid the app doesn't give any feedback to the user only a debugger error message to the developer.
 6) Some public parameters have an extra `_` as a suffix for some reason eg: `UsercentricsUsercentricsConsentType explicit_`.
 7) Content mapping is outdated or missing information, it has less parameters than the actual models inside the SDK(eg: missing `cmpData?.settings.labels.headerModal`). https://docs.usercentrics.com/cmp_in_app_sdk/latest/collect_consent/build_own_ui/#content-mapping
