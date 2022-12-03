# UnderstandingSeizures

<img src="supp/main_figure.png" alt="Alt text" title="">

<p class="text-justify">

**Abstract**. Our project is an attempt to understand epileptic seizures by answering any researcher's questions about a phenomenon: why, where and when using Python. In order to answer these questions, we first analyzed the EEG data of patients from the CHB-MIT database. After making typographic maps of the electrodes over time, we were able to identify the seizure onset zone in the interictal and ictal periods. Indicating that epilepsies arise from an organized interaction in the brain and are interconnected. We then used ECG data from other research on epilepsy patients to reconstruct their biological clocks based on their heart rate cycles and then test for similarity with epileptic cycles. We identified that epilepsies are related to the cardiac cycles of patients, since after all they affect the autonomic nervous system. Finally, two block diagrams were designed for a monitoring system in clinics (EEG, ECG) and a portable one that would be a smartwatch. For this last part, accelerometer data was extracted, created an app with swift and java and connected to a server on the web. It was demonstrated how using the signals collected and various classification methods could detect epileptic episodes.

</p> <br />


### **Seizures are likely due to synchronization and aberrant activities of the interconnected brain network**

The need to accurately identify the seizure initiation zone in the field of surgery to remove these areas has aroused great interest in their characterization, as well as the mechanisms of seizure initiation and propagation. Epileptic network mapping shows promise and as a useful tool to understand these processes. It can also help identify tissues that need to be removed during surgery to prevent seizures while doing as little damage as possible to normal brain function.

<img src="supp/Inter_ictal_EEG.png" alt="Alt text" title="Figure 1. Topographic analysis of EEG activity in 3 patients during the interictal periods of seizures. For the topographic reconstruction of the EEG signals, the international 10-20 electrode system was used. What is observed in the image is the estimation of the spectral power pro welch. The seizure onset zone is located in the central part of the brain.">

