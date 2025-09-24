# ARVO Test Script

This project provides a helper script to **build and run Fluent Bit unit tests**
inside the [`n132/arvo:51132-fix`](https://github.com/n132/ARVO-Meta) Docker image
and copy the artifacts log.

---
### [STEP 1] New terminal window

New terminal not inside the container 

---

### [STEP 2] Create a new file for the script

In the terminal run:

```bash
nano unit_tests.sh
```

---

### [STEP 3] Paste the script

In the nano window, paste the script unit_tests.sh, save and exit.

If your container name is not `arvo-51132`, edit the `CONTAINER="..."` line.

---

### [STEP 4] Executable

In the terminal:

```bash
chmod +x unit_tests.sh
```

---

### [STEP 5] Run the script

Any time you want to rebuild and run the tests:

```bash
./unit_tests.sh
```

---



You’ll see each step (clean, configure, build, list tests, run tests) and when it finishes a log file called

`test_output_51132.txt` will appear in the same folder 
