use std::io::Error;

fn main() -> Result<(), Error> {
    {
        use pyo3::prelude::*;
        // set up python interpreter
        pyo3::prepare_freethreaded_python();
        // the file that we want to run
        let hello_world = include_str!(concat!(env!("CARGO_MANIFEST_DIR"), "/hello_world.py"));
        Python::with_gil(|py| -> PyResult<Py<PyAny>> {
            // run the main() function from hello_world.py
            let app: Py<PyAny> = PyModule::from_code_bound(py, hello_world, "", "")?
                .getattr("main")?
                .into();

            app.call0(py)
        })?;
        Ok(())
    }
}
