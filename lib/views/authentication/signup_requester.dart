import '../../consts/consts.dart';

class SignupRequester extends StatefulWidget {
  const SignupRequester({super.key});

  @override
  State<SignupRequester> createState() => _SignupRequesterState();
}

class _SignupRequesterState extends State<SignupRequester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          becomeRequester,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 30),


              TextField(
                decoration: InputDecoration(
                  labelText: name,
                  hintText: nameHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password TextField
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: password,
                  hintText: passwordHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: email,
                  hintText: emailHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Phone TextField
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: phone,
                  hintText: phoneHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 15),
// Phone TextField
              SizedBox(
                height: 200,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(fontSize: 18),
                  textAlignVertical: TextAlignVertical.top, // Center text vertically
                  decoration: InputDecoration(
                    labelText: addDetails,
                    alignLabelWithHint: true,
                    hintText: addDetailsHint,
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      height: 3, // Adjust this to center better if needed
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),






              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                     submit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}