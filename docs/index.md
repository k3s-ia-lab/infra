# Welcome to UaiSo Serious/Infra

## Why so serious?

UaiSo - Serious?

Unchained Artificial Intelligence Stack/Sandbox Ops/Open -- Why so serious about AI?

This project is a kubernetes "distro", with deployment manifests.

Lot's of AI tools for experimentation.

Local first, privacy first, off-grid first (good to practice compliance stuff).

## Knowledge barrier

AI is a complex field, and getting started can be overwhelming. This project aims to lower the knowledge barrier by
providing a simple and easy-to-deploy kubernetes setup with pre-configured AI tools. The goal is to make it easy for 
anyone to get started with AI, regardless of their technical background.

Another projects like [https://jan.ai](https://jan.ai) or LLM studio are doing a great job on lowering the barrier for
AI experimentation, but they are desktop applications, and not focused on self-hosting.

To better understand of this project, some skills are recommended, but not mandatory:

- Kubernetes
- Linux
- Git / Gitops
- Virtualization
- Networking (including DNS)
- Hardware

## Budget barrier

Today, the budget barrier for AI experimentation is high. Training large models requires significant computational
resources, which can be expensive. Inference can also be costly, but less expensive than training.

There's a relation between your knowledge and your budget. The more you know, the less you will spend. For example,
more understanding about kubernetes, linux, hardware, virtualization, networking, will help you to optimize your setup,
use old hardware, choose what tools to deploy to kubernetes, and avoid unecessary cpu, gpu, ram or storage usage.

### Kubernetes knowledge

If you don't know about kubernetes, there's a script to install k3s with a single command providing argocd + onedev git
repo + squid proxy, but it will eat near 3GB of RAM. It's awesome, user-friendly, but not optimized for low budget 
setups.

If you are a kubernetes pro, you can deploy only what you need with kubectl and helm, and don't need argocd or any 
gitops tool, saving cpu and ram.

## Know your gear

### Hardware considerations

#### CPU

Check if your CPU supports AVX2 instructions. Many community projects requires it, and they don't want to support old
hardware. Microsoft did that with Windows 11, community projects are doing it too, so I guess we have to accept the
eletronic junk that we are massive creating, like we did changing i386 to i686 and amd64. Now we have some kind of
undocumented "amd64_avx2" and "amd64_avx512" builds laying around.

#### VCPU

If you're using virtual machines, make sure to enable CPU passthrough or set the VM to use host CPU features. This will
allow the VM to utilize the full capabilities of the host CPU, including AVX2 instructions.

#### GPU

Today the easiest way to get good performance for AI workloads is using NVIDIA GPUs, due to the great support from
CUDA/CUDAToolkit. AMD GPUs are getting better support with ROCm, but it's still not as widely adopted as NVIDIA's
ecosystem. Intel is also entering the GPU market with their Arc series, but support for AI workloads is still in its
infancy.

#### RAM

AI workloads can be memory intensive, especially when dealing with large models or diffusion models. Make sure to have
enough RAM to handle your specific use case. Check your model size + context size + batch size + other overheads and
your avalilable RAM.

#### (CPU + RAM) vs (GPU + VRAM)

For many AI tasks, paralell processing on a GPU can significantly outperform CPU-based processing. GPU has more cores
that can handle multiple operations simultaneously, making them ideal for the matrix and vector computations common in
AI workloads. The VRAM on a GPU is also optimized for high throughput compared to regular system RAM, which can lead to
faster data access times. GPU cores have floating point units that are specifically designed for the types of
calculations used in AI, such as matrix multiplications and convolutions. This specialized hardware can lead to
significant performance improvements over general-purpose CPU cores.

In a noob friendly way: your LLM or diffusion model can fit your CPU + RAM, but it will be slow. If it fits in GPU +
VRAM, it will be much faster.

#### Unified memory architecture (UMA)

There are some systems with unified memory architecture (UMA), where the CPU and GPU share the same memory pool. This
can be beneficial for certain workloads, as it allows for faster data transfer between the CPU and GPU. However, 
UMA systems may have limitations in terms of total available memory and bandwidth compared to dedicated GPU memory.

Apple's M1/M2/M3/M4 chips are a good example of UMA systems, where the CPU and GPU share the same memory pool.
This can lead to improved performance for certain AI workloads, as data can be accessed more quickly by both the CPU 
and GPU.

Minisforum with AMD Ryzen AI Max+ 395 is another example of UMA system.

#### Ai hardware

There are specialized AI accelerators like Google's TPU, Coral Edge TPU, Rapberry AI HAT (Hailo AI chip), and other 
companies are developing their own AI chips. These can offer significant performance improvements for specific AI tasks 
like vision, text to speech, audio processing.

One promising option is [https://tenstorrent.com/](https://tenstorrent.com/). I hope one day tenstorrent hardware and
filosofy beats NVIDIA's empire.

#### Monitoring

Talking about NVIDIA GPUs, don't forget to monitor your GPU usage, temperature, and memory consumption. Tools like
`nvidia-smi` can help you keep an eye on your GPU's performance and ensure it's running optimally. Zabbix with Grafana
dashboards is also a good option for monitoring with charts and historical data like power consumption, so you can
understand how expensive and not eco friendly is using AI for everything, like saying hi or thanks to a LLM bot,
or generating cute kitty photos with diffusion models.

### Cloud Hardware

When trying cloud hardware, you will feel the pain of paying for expensive GPU instances. Cloud providers charge a
premium for GPU resources, and the costs can add up quickly, especially for long-running AI workloads. Additionally,
cloud instances may have limitations on GPU availability, leading to potential delays in provisioning resources when
needed.

## Why Kubernetes?

Kubernetes can add some complexity to your setup, but it also brings a lot of benefits that can be worth the effort.

The manifests in this project are designed to be simple and easy to deploy, minimizing the complexity typically
associated with docker, docker-compose, local builds, or endless readmes to follow for each tool available on the
community projects.

A huge plus, is understanding how kubernetes works, and learning the concepts behind it, like pods, services,
deployments, configmaps, secrets, ingress, persistent volumes, storage classes, etc. This knowledge can be valuable for
managing modern applications and infrastructure, increasing your skills and adding nice stuff to your personal toolbox.

One day this project will be kubernetes agnostic, today it's using k3s for simplicity. The goal is to be able to deploy
in any kubernetes cluster, like microk8s, k0s, [https://talos.dev](https://talos.dev), kind, minikube, full blown
kubernetes clusters, or cloud-like services.

## Virtualization

Pick one virtualization platform, so you can create and destroy your environment easily. Some good options are:

- Proxmox VE
- Xenserver
- VirtualBox
- Hyper-V

If you have a bare metal computer laying around you can install Xenserver or Proxmox. I personally like Proxmox VE,
because it's open source, has a web interface, supports LXC containers and KVM virtual machines, and has a nice
community. Also it's possible to use pci-e passthrough for GPUs, which is a must have for AI workloads.

Windows users can use Hyper-V, which is built into Windows 10/11 Pro and Enterprise editions.

Linux users can use VirtualBox or KVM/QEMU.

### Without virtualization

If you don't want to use virtualization, you can install k3s directly on your host operating system. I'm not sure if
gpu passthrough will work with windows host inside wsl, or running Docker desktop or Rancher desktop, but on linux
it should work fine.
